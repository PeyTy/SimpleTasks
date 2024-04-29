unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonAdd: TButton;
    ButtonClear: TButton;
    EditTaskText: TEdit;
    Panel1: TPanel;
    Tasks: TCheckGroup;
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TasksItemClick(Sender: TObject; Index: integer);
    procedure UpdateGUI();
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.UpdateGUI();
var
  hasChecked: boolean;
  i, howMany: integer;
begin
  hasChecked := false;

  for i := 0 to Tasks.ControlCount - 1 do begin
    if Tasks.Checked[i] then begin
      hasChecked := true;
    end;
  end;

  ButtonClear.Enabled := hasChecked;
end;

procedure TForm1.ButtonAddClick(Sender: TObject);
var
  input: string;
begin
  input := Trim(EditTaskText.Text);
  if input = '' then exit;
  Tasks.Items.Add(input);
  EditTaskText.Text := '';
  UpdateGUI();
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
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

  UpdateGUI();
  //Tasks.Items.Text := undone;
  //  CheckGroup1.Controls[i].Enabled := CheckGroup1.Checked[i];
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  UpdateGUI();
end;

procedure TForm1.TasksItemClick(Sender: TObject; Index: integer);
begin
  UpdateGUI();
end;

end.

