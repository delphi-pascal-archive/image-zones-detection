unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, inifiles, ComCtrls;

type
  Tprincipale = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Quitter1: TMenuItem;
    Informations: TMenuItem;
    Panel1: TPanel;
    trame: TImage;
    fond: TImage;
    coloriage: TImage;
    zone: TImage;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    Option1: TMenuItem;
    Previsualisation: TMenuItem;
    couleurs: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure zoneMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Quitter1Click(Sender: TObject);
    procedure PrevisualisationClick(Sender: TObject);
    procedure couleursClick(Sender: TObject);
    procedure zoneMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure zoneMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Déclarations privées }
    nbr_zone,derniere_zone:integer;
    couleur_trame:array[0..100] of tcolor;
    bmp:array[0..100] of tbitmap;
    zone_deja_dessinee:array[0..100] of boolean;
  public
    { Déclarations publiques }
  end;

var
  principale: Tprincipale;

implementation

uses Unit2;

{$R *.dfm}

procedure Tprincipale.FormCreate(Sender: TObject);
var inifile:tinifile;
    repertoire:string;
    i:integer;
begin
  Panel1.DoubleBuffered := True; // Sur les conseils très avisés de "JAPEE"
// Ouvrir le fichier CONDITION.INF
  repertoire:=ExtractFilePath(Application.ExeName)+'exemple/';
  Inifile:=tinifile.Create(repertoire+'condition.inf');
  nbr_zone:=Inifile.ReadInteger('NOMBRE DE ZONES','Combien',0);
  for i:=0 to nbr_zone do couleur_trame[i]:=stringtocolor(Inifile.Readstring('COULEUR','Zone'+inttostr(i),'clwhite'));
  Inifile.Free;
// Images
  trame.Picture.LoadFromFile(repertoire+'trame.bmp');
  fond.Picture.LoadFromFile(repertoire+'fond.bmp');
  coloriage.Picture.LoadFromFile(repertoire+'0.bmp');
  zone.Picture.LoadFromFile(repertoire+'0.bmp');
// Images memorisées
  for i:=0 to nbr_zone do begin
    bmp[i]:=tbitmap.Create;
    with bmp[i] do begin
      width:=trame.Width;
      height:=trame.Height;
      LoadFromFile(repertoire+inttostr(i)+'.bmp');
    end;
  end;
// dimension
  panel1.Width:=trame.Width;
  panel1.Height:=trame.Height+19;
// Initialisation
  for i:=0 to nbr_zone do zone_deja_dessinee[i]:=true;
// activation
  previsualisation.Click;
end;

procedure Tprincipale.PrevisualisationClick(Sender: TObject);
begin
  previsualisation.Checked:=not previsualisation.Checked;
  if previsualisation.Checked
    then statusbar1.Panels[0].Text:='Previsualization ACTIVE'
    else statusbar1.Panels[0].Text:='Previsualization DEACTIVE';
end;

procedure Tprincipale.zoneMouseMove(Sender:TObject; Shift:TShiftState; X,Y:Integer);
var couleur_pixel:tcolor;
    rectangle:trect;
    i,zone_encours:integer;
begin
  if not previsualisation.Checked then exit;
  couleur_pixel:=trame.Canvas.Pixels[x,y];
  rectangle:=rect(0,0,trame.Width,trame.Height);
  zone_encours:=nbr_zone+1;
  for i:=0 to nbr_zone do if couleur_pixel=couleur_trame[i] then zone_encours:=i;
  if zone_encours=nbr_zone+1 then exit;
  if zone_encours<>derniere_zone then zone.canvas.CopyRect(rectangle,bmp[zone_encours].Canvas,rectangle);
  derniere_zone:=zone_encours;
  // Informations
  info.couleur_encours.color:=couleur_pixel;
  info.quelle_zone.caption:='Zone : '+inttostr(derniere_zone);
  info.couleur_zone.color:=couleur_trame[derniere_zone];
end;

procedure Tprincipale.FormDestroy(Sender: TObject);
var i:integer;
begin
  for i:=0 to nbr_zone do bmp[i].free;
end;

procedure Tprincipale.Quitter1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure Tprincipale.couleursClick(Sender: TObject);
begin
  info.show;
end;

procedure Tprincipale.zoneMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var couleur_pixel:tcolor;
    rectangle:trect;
    i,zone_encours:integer;
    bmp1,bmp2,bmp3:tbitmap;
begin
  couleur_pixel:=trame.Canvas.Pixels[x,y];
  rectangle:=rect(0,0,trame.Width,trame.Height);
  zone_encours:=nbr_zone+1;
  for i:=0 to nbr_zone do if couleur_pixel=couleur_trame[i] then zone_encours:=i;
  if zone_encours=nbr_zone+1 then exit;

  // Coloriage de la zone de la nouvelle couleur
  bmp1:=tbitmap.Create;
  with bmp1 do begin
    width:=trame.Width;
    height:=trame.Height;
    canvas.CopyRect(rectangle,bmp[zone_encours].Canvas,rectangle);
  end;
  // Coloriage de la zone de l'ancienne couleur
  bmp2:=tbitmap.Create;
  with bmp2 do begin
    width:=trame.Width;
    height:=trame.Height;
    canvas.CopyRect(rectangle,bmp[zone_encours].Canvas,rectangle);
  end;
  // Traitement de l'image
  bmp3:=tbitmap.Create;
  with bmp3 do begin
    width:=trame.Width;
    height:=trame.Height;
    // copie de l'image
    Canvas.CopyMode:=cmsrccopy;
    Canvas.CopyRect(rectangle,coloriage.Canvas,rectangle);
    // Effacement de la zone (normalement il ne doit rester que les couleurs à garder)
    Canvas.CopyMode:=cmsrcerase;
    Canvas.CopyRect(rectangle,bmp2.Canvas,rectangle);
    // Inverser le résultat
    Canvas.CopyMode:=cmdstinvert;
    Canvas.CopyRect(rectangle,Canvas,rectangle);
    if zone_deja_dessinee[zone_encours] then begin
      // Coloriage de la zone
      Canvas.CopyMode:=cmsrcand;
      Canvas.CopyRect(rectangle,bmp1.Canvas,rectangle);
    end;
  end;
  // affichage de l'image
  with coloriage do begin
    Canvas.CopyMode:=cmsrccopy;
    Canvas.CopyRect(rectangle,bmp3.Canvas,rectangle);
  end;
  zone_deja_dessinee[zone_encours]:=not zone_deja_dessinee[zone_encours];
  // Vider la place prise
  bmp1.Free;
  bmp2.free;
  bmp3.free;

end;

procedure Tprincipale.zoneMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    statusbar1.Panels[1].Text:='';
end;

end.
