program zone;

uses
  Forms,
  Unit1 in 'Unit1.pas' {principale},
  Unit2 in 'Unit2.pas' {info};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tprincipale, principale);
  Application.CreateForm(Tinfo, info);
  Application.Run;
end.
