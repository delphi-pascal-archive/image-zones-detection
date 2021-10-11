unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tinfo = class(TForm)
    Panel1: TPanel;
    quelle_zone: TLabel;
    couleur_zone: TPanel;
    couleur_encours: TPanel;
    Label_: TLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  info: Tinfo;

implementation

uses Unit1;

{$R *.dfm}

end.
