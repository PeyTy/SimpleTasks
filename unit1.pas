unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Math;

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
    procedure FormConstrainedResize(Sender: TObject; var MinWidth, MinHeight,
      MaxWidth, MaxHeight: TConstraintSize);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TasksItemClick(Sender: TObject; Index: integer);
    procedure UpdateGUI(FromConstrainedResize: Boolean = false);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.UpdateGUI(FromConstrainedResize: Boolean = false);
var
  hasChecked: boolean;
  i, howMany: integer;
begin
  hasChecked := false;
  howMany := 0;

  for i := 0 to Tasks.ControlCount - 1 do begin
    Tasks.Controls[i].ShowHint := true;
    Tasks.Controls[i].Hint := Tasks.Items[i];
    if Tasks.Columns > 1 then
      Tasks.Controls[i].Constraints.MaxWidth := 300
    else
      Tasks.Controls[i].Constraints.MaxWidth := Width - 16;

    if Tasks.Checked[i] then begin
      hasChecked := true;
      howMany := howMany + 1
    end;
  end;

  ButtonClear.Enabled := hasChecked;

  if howMany > 0 then
    ButtonClear.Caption := 'Clear [' + IntToStr(howMany) + ']'
  else
    ButtonClear.Caption := 'Clear';

  if Width < 600 then begin
    Tasks.Columns := 1;
    Constraints.MinHeight := Max(26 * Tasks.ControlCount, 320);
  end
  else begin
    Tasks.Columns := 2;
    Constraints.MinHeight := Max(13 * Tasks.ControlCount, 320);
  end;

  if (Height < Constraints.MinHeight) and (not FromConstrainedResize) then Height := Constraints.MinHeight + 1;
end;

procedure TForm1.ButtonAddClick(Sender: TObject);
var
  input: string;
begin
  input := Trim(EditTaskText.Text);
  input := StringReplace(input, '&', '&&', [rfReplaceAll]);
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

procedure TForm1.FormConstrainedResize(Sender: TObject; var MinWidth,
  MinHeight, MaxWidth, MaxHeight: TConstraintSize);
begin
  UpdateGUI(true);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  UpdateGUI();
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

