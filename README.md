# TEdgeBrowserPdf
A class helper to generate PDF from a page loaded on a TEdgeBrowser component. 

Example:
```delphi
unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge;

type
  TForm1 = class(TForm)
    EdgeBrowser1: TEdgeBrowser;
    procedure FormCreate(Sender: TObject);
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: TOleEnum);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  UEdgeBrowserPdfHelper;

{$R *.dfm}

procedure TForm1.EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean;
  WebErrorStatus: TOleEnum);
var
  PrintSettings: TPrintSettings;
begin
  if IsSuccess then
  begin
    PrintSettings := TPrintSettings.Default;
    PrintSettings.MarginTop := 0;
    PrintSettings.MarginBottom := 0;
    PrintSettings.MarginLeft := 0.2;
    PrintSettings.MarginRight := 0.2;
    EdgeBrowser1.PrintToPdf('C:\Users\User\Desktop\google.pdf', PrintSettings);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EdgeBrowser1.Navigate('http://www.google.com');
end;

end.
```
