program Ejemplo_de_threads;

uses
  Forms,
  FMain in 'FMain.pas' {FormMain},
  UThreads in 'UThreads.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
