// released under MIT license
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
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

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
     StrPCopy(ComPort, ComboBox1.Items[ComboBox1.ItemIndex]);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  PowerON();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  PowerOFF();
end;

end.

