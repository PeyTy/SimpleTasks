unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Panel1: TPanel;
    Tasks: TCheckGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  input: string;
begin
  input := Trim(Edit1.Text);
  if input = '' then exit;
  Tasks.Items.Add(input);
  Edit1.Text := '';
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i, j: integer;
begin
  j := 0;

  for i := 0 to Tasks.ControlCount - 1 do begin
    if Tasks.Checked[j] then begin
      //Tasks.Checked[i] := false;
      Tasks.Items.Delete(j);
    end else begin
      j := j + 1;
      //undone := undone + #13#10 + Tasks.Items[i];
    end;
  end;

  //Tasks.Items.Text := undone;
  //  CheckGroup1.Controls[i].Enabled := CheckGroup1.Checked[i];
end;

end.

