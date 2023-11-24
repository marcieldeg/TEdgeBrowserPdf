unit UEdgeBrowserPdfHelper;

interface

uses
  Vcl.Edge;

type
  TPrintOrientation = (tpoPortrail, tpoLandscape);

  TPrintSettings = record
    Orientation: TPrintOrientation;
    ScaleFactor: Double;
    PageWidth: Double;
    PageHeight: Double;
    MarginTop: Double;
    MarginBottom: Double;
    MarginLeft: Double;
    MarginRight: Double;
    ShouldPrintBackgrounds: Boolean;
    ShouldPrintSelectionOnly: Boolean;
    ShouldPrintHeaderAndFooter: Boolean;
    HeaderTitle: String;
    FooterUri: String;

    class function Default: TPrintSettings; static;
  end;

  TEdgeBrowserHelper = class helper for TEdgeBrowser
  public
    procedure PrintToPdf(AResultFilePath: String; ASettings: TPrintSettings);
  end;

implementation

uses
  Winapi.WebView2, Winapi.ActiveX;

type
  ICoreWebView2PrintSettings = interface(IUnknown)
    ['{377F3721-C74E-48CA-8DB1-DF68E51D60E2}']
    function Get_Orientation(out Orientation: TOleEnum): HResult; stdcall;
    function Set_Orientation(Orientation: TOleEnum): HResult; stdcall;
    function Get_ScaleFactor(out ScaleFactor: Double): HResult; stdcall;
    function Set_ScaleFactor(ScaleFactor: Double): HResult; stdcall;
    function Get_PageWidth(out PageWidth: Double): HResult; stdcall;
    function Set_PageWidth(PageWidth: Double): HResult; stdcall;
    function Get_PageHeight(out PageHeight: Double): HResult; stdcall;
    function Set_PageHeight(PageHeight: Double): HResult; stdcall;
    function Get_MarginTop(out MarginTop: Double): HResult; stdcall;
    function Set_MarginTop(MarginTop: Double): HResult; stdcall;
    function Get_MarginBottom(out MarginBottom: Double): HResult; stdcall;
    function Set_MarginBottom(MarginBottom: Double): HResult; stdcall;
    function Get_MarginLeft(out MarginLeft: Double): HResult; stdcall;
    function Set_MarginLeft(MarginLeft: Double): HResult; stdcall;
    function Get_MarginRight(out MarginRight: Double): HResult; stdcall;
    function Set_MarginRight(MarginRight: Double): HResult; stdcall;
    function Get_ShouldPrintBackgrounds(out ShouldPrintBackgrounds: Integer): HResult; stdcall;
    function Set_ShouldPrintBackgrounds(ShouldPrintBackgrounds: Integer): HResult; stdcall;
    function Get_ShouldPrintSelectionOnly(out ShouldPrintSelectionOnly: Integer): HResult; stdcall;
    function Set_ShouldPrintSelectionOnly(ShouldPrintSelectionOnly: Integer): HResult; stdcall;
    function Get_ShouldPrintHeaderAndFooter(out ShouldPrintHeaderAndFooter: Integer): HResult; stdcall;
    function Set_ShouldPrintHeaderAndFooter(ShouldPrintHeaderAndFooter: Integer): HResult; stdcall;
    function Get_HeaderTitle(out HeaderTitle: PWideChar): HResult; stdcall;
    function Set_HeaderTitle(HeaderTitle: PWideChar): HResult; stdcall;
    function Get_FooterUri(out FooterUri: PWideChar): HResult; stdcall;
    function Set_FooterUri(FooterUri: PWideChar): HResult; stdcall;
  end;

  ICoreWebView2PrintToPdfCompletedHandler = interface(IUnknown)
    ['{CCF1EF04-FD8E-4D5F-B2DE-0983E41B8C36}']
    function Invoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;
  end;

  ICoreWebView2_7 = interface(ICoreWebView2)
    ['{79C24D83-09A3-45AE-9418-487F32A58740}']
    // ICoreWebView2_2
    function add_WebResourceResponseReceived(const eventHandler: IUnknown; out token: IUnknown): HResult; stdcall;
    function remove_WebResourceResponseReceived(token: IUnknown): HResult; stdcall;
    function NavigateWithWebResourceRequest(const Request: IUnknown): HResult; stdcall;
    function add_DOMContentLoaded(const eventHandler: IUnknown; out token: IUnknown): HResult; stdcall;
    function remove_DOMContentLoaded(token: EventRegistrationToken): HResult; stdcall;
    function Get_CookieManager(out CookieManager: IUnknown): HResult; stdcall;
    function Get_Environment(out Environment: IUnknown): HResult; stdcall;
    // ICoreWebView2_3
    function TrySuspend(const handler: IUnknown): HResult; stdcall;
    function Resume: HResult; stdcall;
    function Get_IsSuspended(out IsSuspended: Integer): HResult; stdcall;
    function SetVirtualHostNameToFolderMapping(hostName: PWideChar; folderPath: PWideChar; accessKind: TOleEnum)
      : HResult; stdcall;
    function ClearVirtualHostNameToFolderMapping(hostName: PWideChar): HResult; stdcall;
    // ICoreWebView2_4
    function add_FrameCreated(const eventHandler: IUnknown; out token: IUnknown): HResult; stdcall;
    function remove_FrameCreated(token: IUnknown): HResult; stdcall;
    function add_DownloadStarting(const eventHandler: IUnknown; out token: IUnknown): HResult; stdcall;
    function remove_DownloadStarting(token: IUnknown): HResult; stdcall;
    // ICoreWebView2_5
    function add_ClientCertificateRequested(const eventHandler: IUnknown; out token: IUnknown): HResult; stdcall;
    function remove_ClientCertificateRequested(token: IUnknown): HResult; stdcall;
    // ICoreWebView2_6
    function OpenTaskManagerWindow: HResult; stdcall;
    //
    function PrintToPdf(ResultFilePath: PWideChar; const printSettings: ICoreWebView2PrintSettings;
      const handler: ICoreWebView2PrintToPdfCompletedHandler): HResult; stdcall;
  end;

  ICoreWebView2Environment6 = interface(ICoreWebView2Environment)
    ['{E59EE362-ACBD-4857-9A8E-D3644D9459A9}']
    // ICoreWebView2Environment2
    function CreateWebResourceRequest(uri: PWideChar; Method: PWideChar; const postData: IStream; Headers: PWideChar;
      out Request: IUnknown): HResult; stdcall;
    // ICoreWebView2Environment3
    function CreateCoreWebView2CompositionController(var ParentWindow: _RemotableHandle; const handler: IUnknown)
      : HResult; stdcall;
    function CreateCoreWebView2PointerInfo(out pointerInfo: IUnknown): HResult; stdcall;
    // ICoreWebView2Environment4
    function GetProviderForHwnd(var hwnd: _RemotableHandle; out provider: IUnknown): HResult; stdcall;
    // ICoreWebView2Environment5
    function add_BrowserProcessExited(const eventHandler: IUnknown; out token: IUnknown): HResult; stdcall;
    function remove_BrowserProcessExited(token: IUnknown): HResult; stdcall;
    //
    function CreatePrintSettings(out printSettings: ICoreWebView2PrintSettings): HResult; stdcall;
  end;

  { TEdgeBrowserHelper }

procedure TEdgeBrowserHelper.PrintToPdf(AResultFilePath: String; ASettings: TPrintSettings);
var
  WebView7: ICoreWebView2_7;
  printSettings: ICoreWebView2PrintSettings;
  Environment: ICoreWebView2Environment6;
begin
  if Self.DefaultInterface.QueryInterface(ICoreWebView2_7, WebView7) = S_OK then
  begin
    if Self.EnvironmentInterface.QueryInterface(ICoreWebView2Environment6, Environment) = S_OK then
    begin
      Environment.CreatePrintSettings(printSettings);
      printSettings.Set_Orientation(TOleEnum(ASettings.Orientation));
      printSettings.Set_ScaleFactor(ASettings.ScaleFactor);
      printSettings.Set_PageWidth(ASettings.PageWidth);
      printSettings.Set_PageHeight(ASettings.PageHeight);
      printSettings.Set_MarginTop(ASettings.MarginTop);
      printSettings.Set_MarginBottom(ASettings.MarginBottom);
      printSettings.Set_MarginLeft(ASettings.MarginLeft);
      printSettings.Set_MarginRight(ASettings.MarginRight);
      printSettings.Set_ShouldPrintBackgrounds(Integer(ASettings.ShouldPrintBackgrounds));
      printSettings.Set_ShouldPrintSelectionOnly(Integer(ASettings.ShouldPrintSelectionOnly));
      printSettings.Set_ShouldPrintHeaderAndFooter(Integer(ASettings.ShouldPrintHeaderAndFooter));
      printSettings.Set_HeaderTitle(PChar(ASettings.HeaderTitle));
      printSettings.Set_FooterUri(PChar(ASettings.FooterUri));
    end;
    WebView7.PrintToPdf(PChar(AResultFilePath), printSettings, nil);
  end;
end;

{ TPrintSettings }

class function TPrintSettings.Default: TPrintSettings;
begin
  Result.Orientation := tpoPortrail;
  Result.ScaleFactor := 1.0;
  Result.PageWidth := 8.5;
  Result.PageHeight := 11.0;
  Result.MarginTop := 0.4;
  Result.MarginBottom := 0.4;
  Result.MarginLeft := 0.4;
  Result.MarginRight := 0.4;
  Result.ShouldPrintBackgrounds := True;
  Result.ShouldPrintSelectionOnly := False;
  Result.ShouldPrintHeaderAndFooter := False;
  Result.HeaderTitle := '';
  Result.FooterUri := '';
end;

end.
