{
Copyright (©) 2005,  by Germán Estévez (Neftalí)
http://neftali.clubdelphi.com/

  Muestra el funcionamiento de varios threads diferentes.

=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras, ampliaciones,
  errores y/o cualquier otro tipo de sugerencia envíame un mail a:
  german_ral@hotmail.com

IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements,
errors and/or any another type of suggestion send a mail to:
german_ral@hotmail.com
=========================================================================

@author Germán Estévez (Neftalí)
@cat Samples
}
unit UThreads;

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  Classes, ExtCtrls, Windows, ComCtrls;

type

  //: Clase para definir un Thread con prograssBar
  TProgressBarThread = class(TThread)
  private
    pb: TProgressBar;
    FStep: Integer;
  protected
    procedure Execute; override;
    procedure MoveTh;
  public
    property Step:Integer read FStep write FStep;
    constructor Create(Box: TProgressBar; AStep:Integer; ThreadPriority: TThreadPriority);
  end;

  //: Clase para definir un Thread que modifica el color de un panel
  TPanelColorThread = class(TThread)
  private
    pnb: TPanel;
    FColor: Integer;
  protected
    procedure Execute; override;
    procedure ChangeColor;
  public
    constructor Create(APanel: TPanel; ThreadPriority: TThreadPriority);
  end;

  //: Clase para definir un Thread que hace botar una bola dentro de unpanel.
  TBallThread = class(TThread)
  private
    sh: TShape;
    pnl:TPanel;
    FDirection: Integer;
  protected
    procedure Execute; override;
    procedure ChangePosition;
  public
    constructor Create(AShape: TShape; APanel:TPanel; ThreadPriority: TThreadPriority);
  end;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  graphics;

{ TProgressBarThread }
constructor TProgressBarThread.Create(Box: TProgressBar; AStep:Integer;
                                      ThreadPriority: TThreadPriority);
begin
  inherited Create(False);
  Self.FStep := AStep;
  pb := Box;
end;

procedure TProgressBarThread.Execute;
begin

    while true do begin
      Synchronize(MoveTh);
      Sleep(50);
    end;

end;

procedure TProgressBarThread.MoveTh();
begin
  pb.Position := (pb.Position + FStep) MOD 100;
end;


{ TPanelColorThread }
procedure TPanelColorThread.ChangeColor;
begin
  FColor := RGB(Random(255), Random(255), Random(255));
  pnb.Color := FColor;
end;

constructor TPanelColorThread.Create(APanel: TPanel;
                                     ThreadPriority: TThreadPriority);
begin
  inherited Create(False);
  pnb := APanel;
end;

procedure TPanelColorThread.Execute;
begin
  Randomize;

  while true do begin
    Synchronize(ChangeColor);
    sleep(60);
  end;

end;

{ TBallThread }

procedure TBallThread.ChangePosition;
begin

  sh.Top := sh.Top + FDirection;

  // Ha llegado al tope?
  if (FDirection > 0) and (sh.Top + sh.Height + Abs(FDirection) >= (pnl.Height)) then begin
    FDirection := -5;
    Exit;
  end;
  if (FDirection < 0) and (sh.Top <= Abs(FDirection)) then begin
    FDirection := 5;
    Exit;
  end;


end;

constructor TBallThread.Create(AShape: TShape; APanel:TPanel;
                               ThreadPriority: TThreadPriority);
begin

  inherited Create(False);

  sh := AShape;
  pnl := APanel;
  FDirection := 5;

end;

procedure TBallThread.Execute();
begin

  while true do begin
    Synchronize(ChangePosition);
    sleep(20);
  end;

end;

end.

