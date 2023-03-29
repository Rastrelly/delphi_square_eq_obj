unit usquareeqobj;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  TSolver = class
    private
      fa,fb,fc:real;
      fd:real;
      fx1,fx2:real;
      frv:boolean;
    public
      function ValFromString(str_val:string):real;
      function FindD(a,b,c:real):real;
      procedure calcRoots;
      procedure rootState(var x1,x2:real; var rootvalid:boolean);
      procedure setupCoeffs(ca,cb,cc:real);
      function printRoots:string;
      constructor Create;
      constructor Create(ca,cb,cc:real);
      property a:real
          read fa write fa;
      property b:real
          read fb write fb;
      property c:real
          read fc write fc;
  end;

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

function TSolver.ValFromString(str_val:string):real;
var res:real;
begin
  if not tryStrToFloat(str_val,res) then res:=0;
  result:=res;
end;

function TSolver.FindD(a,b,c:real):real;
begin
  result:=sqr(fb)-4*a*c;
end;

procedure TSolver.calcRoots;
var rootsvalid:boolean;
begin
  fd:=FindD(fa,fb,fc);
  if not (fd<0) then
  begin
    fx1:=(-fb-sqrt(fd))/(2*fa);
    fx2:=(-fb+sqrt(fd))/(2*fa);
    rootsvalid:=true;
  end
  else
  begin
    rootsvalid:=false;
    fx1:=0; fx2:=0;
  end;
  frv:=rootsvalid;
end;

procedure TSolver.rootState(var x1,x2:real; var rootvalid:boolean);
begin
  x1:=fx1; x2:=fx2;
  rootvalid:=frv;
end;

function TSolver.printRoots:string;
begin
  if frv then
  begin
    result:='x1='+floattostr(fx1)+'; x2='+floattostr(fx2);
  end
  else
  begin
    result:='No Valid Roots Found';
  end;
end;

procedure TSolver.setupCoeffs(ca,cb,cc:real);
begin
  fa:=ca; fb:=cb; fc:=cc;
end;

constructor TSolver.Create;
begin
  fa:=0; fb:=0; fc:=0; fd:=-1; fx1:=0; fx2:=0; frv:=false;
end;

constructor TSolver.Create(ca,cb,cc:real);
begin
  setupCoeffs(ca,cb,cc);
  fd:=-1; fx1:=0; fx2:=0; frv:=false;
end;

end.

