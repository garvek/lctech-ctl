// released under MIT license
unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows, Dialogs;

var
  ComPort: array[0..80] of Char = 'COM1';

procedure PowerOn();
procedure PowerOff();

implementation

var
  ComFile: THandle = INVALID_HANDLE_VALUE;

procedure OpenCom();
var
  Dcb: TDCB;

begin
     ComFile := CreateFile(ComPort,
       GENERIC_WRITE,
       0,
       nil,
       OPEN_EXISTING,
       FILE_ATTRIBUTE_NORMAL,
       0);
     if ComFile = INVALID_HANDLE_VALUE then
        Exit;

     Dcb := Default(TDCB);
     if not GetCommState(ComFile, Dcb) then
        Exit;

     with Dcb do
     begin
       BaudRate := 9600;
       ByteSize := 8;
       Parity := NOPARITY;
       StopBits := ONESTOPBIT;
       Flags := $1;  // enable binary
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
       WriteFile(ComFile, s[1], Length(s), BytesWritten, nil);
       if BytesWritten <> Length(s) then
       begin
         ShowMessage('Timeout');
       end;
     end
     else
     begin
       ShowMessage('Cannot open COM port');
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

