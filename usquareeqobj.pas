unit usquareeqobj;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, usqesolver;

type

  { TForm1 }

  TForm1 = class(TForm)
    Calculate: TButton;
    edA: TEdit;
    edB: TEdit;
    edC: TEdit;
    Memo1: TMemo;
    procedure CalculateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  solver:TSolver;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CalculateClick(Sender: TObject);
begin
  solver.setupCoeffs(solver.ValFromString(edA.Text),
                     solver.ValFromString(edB.Text),
                     solver.ValFromString(edC.Text));
  solver.calcRoots;
  memo1.lines.add(solver.printRoots);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  solver:=TSolver.Create;
end;

end.

