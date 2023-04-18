unit WP.ProjTreePlugin.Resources;

interface


uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TdmProjTreePluginResources = class(TDataModule)
    ImageCollection1: TImageCollection;
  end;


var
  dmProjTreePluginResources: TdmProjTreePluginResources;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

initialization

dmProjTreePluginResources := TdmProjTreePluginResources.Create(nil);

finalization

FreeAndNil(dmProjTreePluginResources);

end.
