unit CustomEffect.Interfaces;

interface

uses
  Vcl.Forms;

type
  ICustomEffectCore = interface
    ['{30DACCFC-F627-48D7-8761-9AAEFB9BF9AC}']
    procedure EscurecerTela(AForm: TForm);
    procedure ClarearTela(AForm: TForm);
  end;

implementation

end.
