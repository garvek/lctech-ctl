// (c) Sylvain T 2020
// released under MIT license
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Unit2;

const

  VERSION = '1.3';

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonON: TButton;
    ButtonOFF: TButton;
    ButtonAbout: TButton;
    CheckBoxStayOnTop: TCheckBox;
    ComboBoxComPort: TComboBox;
    LabelComPort: TLabel;
    procedure ButtonAboutClick(Sender: TObject);
    procedure ButtonONClick(Sender: TObject);
    procedure ButtonOFFClick(Sender: TObject);
    procedure CheckBoxStayOnTopChange(Sender: TObject);
    procedure ComboBoxComPortChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.ComboBoxComPortChange(Sender: TObject);
begin
     StrPCopy(ComPort, ComboBoxComPort.Items[ComboBoxComPort.ItemIndex]);
end;

procedure TForm1.ButtonONClick(Sender: TObject);
begin
  PowerON();
end;

procedure TForm1.ButtonAboutClick(Sender: TObject);
begin
  ShowMessage('LCTech Ctl tool V' + VERSION);
end;

procedure TForm1.ButtonOFFClick(Sender: TObject);
begin
  PowerOFF();
end;

procedure TForm1.CheckBoxStayOnTopChange(Sender: TObject);
begin
  if CheckBoxStayOnTop.Checked then
  begin
    Form1.FormStyle := fsSystemStayOnTop;
  end
  else
  begin
    Form1.FormStyle := fsNormal;
  end;
end;

end.

