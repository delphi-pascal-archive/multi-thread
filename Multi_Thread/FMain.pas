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

unit FMain;

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ShellAPI;

type
  TFormMain = class(TForm)
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    cb1: TCheckBox;
    cb2: TCheckBox;
    cb3: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pb1: TProgressBar;
    pb2: TProgressBar;
    pb3: TProgressBar;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    TrackBar4: TTrackBar;
    CheckBox1: TCheckBox;
    pnlColor1: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    TrackBar5: TTrackBar;
    CheckBox2: TCheckBox;
    pnlBall: TPanel;
    shBall: TShape;
    Bevel1: TBevel;
    Button1: TButton;
    StatusBar2: TStatusBar;
    procedure TrackBar1Change(Sender: TObject);
    procedure cb1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StatusBar2Click(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

{$R *.DFM}

uses
  UThreads;

var
  Tpb1:TProgressBarThread;
  Tpb2:TProgressBarThread;
  Tpb3:TProgressBarThread;

  TpnlC1:TPanelColorThread;
  TBall1:TBallThread;


procedure TFormMain.TrackBar1Change(Sender: TObject);
var
  Th: TThread;
begin
  // El sender es un TTrackBar
  if Sender is TTrackBar then
    // A partir del TAG accedemos a cual es
    with TTrackBar(Sender) do begin
      case Tag of
        1: Th:= Tpb1;
        2: Th:= Tpb2;
        3: Th:= Tpb3;
        4: Th:= TpnlC1;
        5: Th:= TBall1;
      end;

      // Cambiamos la prioridad
      Case Position of
        1: Th.Priority:= tpIdle;
        2: Th.Priority:= tpLowest;
        3: Th.Priority:= tpLower;
        4: Th.Priority:= tpNormal;
        5: Th.Priority:= tpHigher;
        6: Th.Priority:= tpHighest;
        7: Th.Priority:= tpTimeCritical;
      end;
    end;
end;

procedure TFormMain.cb1Click(Sender: TObject);
var
  Th: TThread;
begin
  // Es un CheckBox
  if Sender is TCheckBox then
    // Accedemos a cual es a partir del TAG
    with TCheckBox(Sender) do begin
      case Tag of
        1: Th:= Tpb1;
        2: Th:= Tpb2;
        3: Th:= Tpb3;
        4: Th:= TpnlC1;
        5: Th:= TBall1;
      end;
      // Suspender o reanudar
      if Th.Suspended then Th.Resume else Th.Suspend;
    end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  // crear threads de barras de progreso
  Tpb1 := TProgressBarThread.Create(pb1, 1, tpNormal);
  Tpb2 := TProgressBarThread.Create(pb2, 2, tpNormal);
  Tpb3 := TProgressBarThread.Create(pb3, 5, tpNormal);
  TpnlC1 := TPanelColorThread.Create(pnlColor1, tpNormal);
  TBall1 := TBallThread.Create(shBall, pnlBall, tpNormal);
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.StatusBar2Click(Sender: TObject);
begin
  // Página web
  ShellExecute(Handle, 'open', 'http://neftali.clubdelphi.com/', nil, nil, 0);
end;

end.
