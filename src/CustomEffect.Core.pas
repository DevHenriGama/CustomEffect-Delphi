unit CustomEffect.Core;

interface

uses
  Vcl.Forms, System.Generics.Collections, CustomEffect.Blackscreen,
  CustomEffect.Interfaces;

type
  TCustomEffect = class(TInterfacedObject, ICustomEffectCore)
    procedure CloseForm(Sender: TObject; var Action: TCloseAction);
  private
    FBSList: TObjectDictionary<TObject, TForm>;
    constructor PrivateConstructor;
  public
    class function GetInstance: TCustomEffect;
    class function New: TCustomEffect;
    constructor create; deprecated;
    destructor destroy; override;

    procedure EscurecerTela(AForm: TForm);
    procedure ClarearTela(AForm: TForm);
  end;

var
  CustomEffect: TCustomEffect;

implementation

uses
  System.SysUtils;

{ TCustomEffect }

procedure TCustomEffect.ClarearTela(AForm: TForm);
var
  FForm: TEffectBlackScreen;
begin
  if not Assigned(AForm) then
    exit;

  if not FBSList.ContainsKey(AForm) then
    exit;

  FBSList.Remove(AForm);

  AForm.Close;

end;

procedure TCustomEffect.CloseForm(Sender: TObject; var Action: TCloseAction);
begin
  ClarearTela(TForm(Sender));
end;

constructor TCustomEffect.create;
begin
  raise Exception.create('Ultilizar o m�todo GetInstance');
end;

destructor TCustomEffect.destroy;
begin
  inherited;
  FBSList.Clear;
  FBSList.Free;
end;

procedure TCustomEffect.EscurecerTela(AForm: TForm);
var
  LEffect: TEffectBlackScreen;
begin
  if not Assigned(AForm) then
    exit;

  if FBSList.ContainsKey(AForm) then
    exit;

  AForm.Position := poScreenCenter;

  LEffect := TEffectBlackScreen.create(nil);
  FBSList.Add(AForm, LEffect);

  LEffect.Show;
  AForm.ShowModal;
end;

class function TCustomEffect.GetInstance: TCustomEffect;
begin
  if not Assigned(CustomEffect) then
  begin
    CustomEffect := TCustomEffect.PrivateConstructor;
  end;
  Result := CustomEffect;
end;

class function TCustomEffect.New: TCustomEffect;
begin
  Result := GetInstance;
end;

constructor TCustomEffect.PrivateConstructor;
begin
  FBSList := TObjectDictionary<TObject, TForm>.create([doOwnsValues]);
end;

end.
