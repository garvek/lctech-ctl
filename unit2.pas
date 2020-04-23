// released under MIT license
unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows, Dialogs;

var
  ComPort: array[0..4] of Char = 'COM1';  // COMxx

procedure PowerOn();
procedure PowerOff();

implementation

var
  ComFile: THandle = INVALID_HANDLE_VALUE;

procedure OpenCom();
var
  Device: array[0..10] of Char;
  Dcb: TDCB;

begin
     Device := '\\.\' + ComPort;
     ComFile := CreateFile(Device,
       GENERIC_READ or GENERIC_WRITE,
       0,
       nil,
       OPEN_EXISTING,
       FILE_ATTRIBUTE_NORMAL,
       0);
     if ComFile = INVALID_HANDLE_VALUE then
     begin
        ShowMessage('Cannot open COM port');
        Exit;
     end;

     Dcb := Default(TDCB);
     if not GetCommState(ComFile, Dcb) then
        Exit;

     with Dcb do
     begin
       BaudRate := 9600;
       ByteSize := 8;
       Parity := NOPARITY;
       StopBits := ONESTOPBIT;
       Flags := bm_DCB_fBinary;
     end;
     if not SetCommState(ComFile, Dcb) then
        Exit;
end;

procedure CloseCom();
begin
     if ComFile <> INVALID_HANDLE_VALUE then
     begin
       CloseHandle(ComFile);
       ComFile := INVALID_HANDLE_VALUE;
     end;
end;

procedure SendString(s: string);
var
  BytesWritten: DWORD = 0;
begin
     if ComFile <> INVALID_HANDLE_VALUE then
     begin
       if not WriteFile(ComFile, s[1], Length(s), BytesWritten, nil) then
       begin
         ShowMessage('Timeout write');
       end;
     end;
end;

procedure PowerON();
var
  s: string;
begin
     s:= #$A0 + #$01 + #$01 + #$A2;
     OpenCom();
     SendString(s);
     CloseCom();
end;

procedure PowerOFF();
var
  s: string;
begin
     s:= #$A0 + #$01 + #$00 + #$A1;
     OpenCom();
     SendString(s);
     CloseCom();
end;

end.

