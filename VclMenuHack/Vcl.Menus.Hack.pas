(*
   Vcl.Menus.Hack unit - Patches TMenu class to paint themed menu’s icons

   Copyright © Alexey Pokroy (apokroy@gmail.com)

   Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

   Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
   Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
   Neither the name of The author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

   This software is provided by The author and contributors "as is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall The author and contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.
*)

unit Vcl.Menus.Hack;

interface

{$IFDEF MSWINDOWS}

uses
  Winapi.Windows,
  System.Types, System.SysUtils, System.Classes, System.UITypes, System.Generics.Collections,
  Vcl.Graphics, Vcl.ImgList, Vcl.Menus;

type
  TMenuHack = class(Vcl.Menus.TMenu)
  protected type
    PPatch = ^TPatch;
    TPatch = packed record
      Jump: Byte;
      Offset: Integer;
    end;
    class function  Patch(Old, New: Pointer; var Origin: TPatch): Boolean;
    class procedure Restore(Addr: Pointer; var Origin: TPatch);
  protected
    class var StartCount: NativeInt;
    class var ImageCache: TDictionary<TImageIndex, TBitmap>;
    class var Origin_AdjustBiDiBehavior: TPatch;
    class var Origin_DispatchPopup: TPatch;
    class constructor Create;
    class destructor Destroy;
    procedure Patch_AdjustBiDiBehavior;
    function  Patch_DispatchPopup(AHandle: HMENU): Boolean;
    procedure UpdateMenu;
    procedure UpdateItem(Item: TMenuItem);
  public
    class procedure Start;
    class procedure Stop;
  end;
{$ELSE}
type
  TMenuHack = class(Vcl.Menus.TMenu)
  public
    class procedure Start;
    class procedure Stop;
  end;
{$ENDIF}

implementation

{$IFDEF MSWINDOWS}

uses
  Vcl.Themes, Vcl.VirtualImageList;

{ TMenuHack }

class constructor TMenuHack.Create;
begin
  ImageCache := TDictionary<TImageIndex, TBitmap>.Create;
  StartCount := 0;
end;

class procedure TMenuHack.Start;
begin
  if StartCount = 0 then
  begin
    Patch(@TPopupMenu.AdjustBiDiBehavior, @TMenuHack.Patch_AdjustBiDiBehavior, Origin_AdjustBiDiBehavior);
    Patch(@TPopupMenu.DispatchPopup,      @TMenuHack.Patch_DispatchPopup, Origin_DispatchPopup);
  end;
  Inc(StartCount);
end;

class procedure TMenuHack.Stop;
begin
  Dec(StartCount);
  if StartCount = 0 then
  begin
    Restore(@TPopupMenu.AdjustBiDiBehavior, Origin_AdjustBiDiBehavior);
    Restore(@TPopupMenu.DispatchPopup,      Origin_DispatchPopup);
  end;
end;

class destructor TMenuHack.Destroy;
begin
  Stop;
  for var Cache in ImageCache do
    FreeAndNil(Cache.Value);
  FreeAndNil(ImageCache);
end;

class function TMenuHack.Patch(Old, New: Pointer; var Origin: TPatch): Boolean;
var
  Size: NativeUInt;
  Code: TPatch;
begin
  if ReadProcessMemory(GetCurrentProcess, Old, @Origin, SizeOf(Origin), Size) then
  begin
    Code.Jump := $E9;
    Code.Offset := PByte(New) - PByte(Old) - SizeOf(Code);
    Result := WriteProcessMemory(GetCurrentProcess, Old, @Code, SizeOf(Code), Size);
  end
  else
  begin
    Origin.Jump := 0;
    Result := False;
  end;
end;

class procedure TMenuHack.Restore(Addr: Pointer; var Origin: TPatch);
var
  Size: NativeUInt;
begin
  if Origin.Jump <> 0 then
    WriteProcessMemory(GetCurrentProcess, Addr, @Origin, SizeOf(Origin), Size);
end;

procedure TMenuHack.UpdateItem(Item: TMenuItem);
const
  Breaks: array[TMenuBreak] of DWORD = (0, MFT_MENUBREAK, MFT_MENUBARBREAK);
var
  MenuItemInfo: TMenuItemInfo;
  Bitmap: TBitmap;
begin
  if OwnerDraw or (Images = nil) then
    Exit;

  var Caption := Item.Caption;
  if (Item.ShortCut <> scNone) and ((Item.Parent = nil) or (Item.Parent.Parent <> nil) or not (Item.Parent.Owner is TMainMenu)) then
    Caption := Caption + #9 + ShortCutToText(Item.ShortCut);

  FillChar(MenuItemInfo, SizeOf(MenuItemInfo), 0);
  MenuItemInfo.cbSize := SizeOf(MenuItemInfo);
  MenuItemInfo.fMask := MIIM_STRING or MIIM_BITMAP or MIIM_FTYPE;
  MenuItemInfo.cch := Length(Caption);
  MenuItemInfo.dwTypeData := PChar(Caption);

  if (Item.Bitmap <> nil) and not Item.Bitmap.Empty then
    MenuItemInfo.hbmpItem := Item.Bitmap.Handle
  else if (Item.ImageIndex >= 0) and (Item.ImageIndex < Images.Count) then
  begin
    if not ImageCache.TryGetValue(Item.ImageIndex, Bitmap) then
    begin
      if (Images is TVirtualImageList) and (TVirtualImageList(Images).ImageCollection <> nil) then
      begin
        var ImageIndex := TVirtualImageList(Images).Images[Item.ImageIndex].CollectionIndex;
        Bitmap := TVirtualImageList(Images).ImageCollection.GetBitmap(ImageIndex, Images.Width, Images.Height);
        Bitmap.AlphaFormat := afPremultiplied;
      end
      else
      begin
        Bitmap := TBitmap.Create;
        try
          Bitmap.SetSize(Images.Width, Images.Height);
          Bitmap.PixelFormat := pf32bit;
          Images.GetBitmap(Item.ImageIndex, Bitmap);
          Bitmap.AlphaFormat := afPremultiplied;
        except
          Bitmap.Free;
          raise;
        end;
      end;
      ImageCache.Add(Item.ImageIndex, Bitmap);
    end;

    MenuItemInfo.hbmpItem := Bitmap.Handle;
  end;

  MenuItemInfo.fType := MenuItemInfo.fType or Breaks[Item.Break];
  if Item.RadioItem then
    MenuItemInfo.fType := MenuItemInfo.fType or MFT_RADIOCHECK
  else if Item.Caption = '-' then
    MenuItemInfo.fType := MenuItemInfo.fType or MFT_SEPARATOR;
  if MenuItemInfo.fType <> 0 then
    MenuItemInfo.fMask := MenuItemInfo.fMask or MIIM_FTYPE;

  SetMenuItemInfo(Handle, Item.Command, False, MenuItemInfo);

  for var I := 0 to Item.Count - 1 do
    UpdateItem(Item[I]);
end;

procedure TMenuHack.UpdateMenu;
begin
  // We can safely clear cache, because there cannot be two simultaneous popups
  for var Cache in ImageCache do
    FreeAndNil(Cache.Value);
  ImageCache.Clear;

  // Let StyleServices draw themselves
  if StyleServices.Enabled and not StyleServices.IsSystemStyle then
    Exit;

  UpdateItem(Items);
  DrawMenuBar(WindowHandle);
end;

procedure TMenuHack.Patch_AdjustBiDiBehavior;
begin
  Restore(@TPopupMenu.AdjustBiDiBehavior, Origin_AdjustBiDiBehavior);
  try
    AdjustBiDiBehavior;
  finally
    Patch(@TPopupMenu.AdjustBiDiBehavior, @TMenuHack.Patch_AdjustBiDiBehavior, Origin_AdjustBiDiBehavior);
  end;

  UpdateMenu;
end;

function TMenuHack.Patch_DispatchPopup(AHandle: HMENU): Boolean;
begin
  Restore(@TPopupMenu.DispatchPopup, Origin_DispatchPopup);
  try
    Result := DispatchPopup(AHandle);
    if Result then
    begin
      var Item := FindItem(AHandle, fkHandle);
      if Item <> nil then
        UpdateItem(Item);
    end;
  finally
    Patch(@TPopupMenu.DispatchPopup, @TMenuHack.Patch_DispatchPopup, Origin_DispatchPopup);
  end;
end;

{$ELSE}
class procedure TMenuHack.Start;
begin
end;

class procedure TMenuHack.Stop;
begin
end;
{$ENDIF}

end.


