// AboutDialog.cpp

#include "StdAfx.h"

#include "../../../../C/CpuArch.h"

#include "../../MyVersion.h"

#include "../Common/LoadCodecs.h"

#include "AboutDialog.h"
#include "PropertyNameRes.h"

#include "HelpUtils.h"
#include "LangUtils.h"

#ifdef Z7_LANG
static const UInt32 kLangIDs[] =
{
  IDT_ABOUT_INFO
};
#endif

#define kLicenseFileName TEXT("Documentos\\Licencas-e-Avisos.txt")
#define kHelpTopic "start.htm"

#define LLL_(quote) L##quote
#define LLL(quote) LLL_(quote)

extern CCodecs *g_CodecsObj;

bool CAboutDialog::OnInit()
{
  #ifdef Z7_EXTERNAL_CODECS
  if (g_CodecsObj)
  {
    UString s;
    g_CodecsObj->GetCodecsErrorMessage(s);
    if (!s.IsEmpty())
      MessageBoxW(GetParent(), s, L"Amurel ZIP", MB_ICONERROR);
  }
  #endif

  #ifdef Z7_LANG
  LangSetWindowText(*this, IDD_ABOUT);
  LangSetDlgItems(*this, kLangIDs, Z7_ARRAY_SIZE(kLangIDs));
  #endif
  SetItemText(IDT_ABOUT_VERSION, UString("AMUREL ZIP " MY_VERSION_CPU));
  SetItemText(IDT_ABOUT_DATE, L"Desenvolvido pela AMUREL");
  
  NormalizePosition();
  return CModalDialog::OnInit();
}

void CAboutDialog::OnHelp()
{
  ShowHelpWindow(kHelpTopic);
}

bool CAboutDialog::OnButtonClicked(unsigned buttonID, HWND buttonHWND)
{
  if (buttonID != IDB_ABOUT_LICENSES)
    return CModalDialog::OnButtonClicked(buttonID, buttonHWND);

  TCHAR path[MAX_PATH];
  const DWORD size = ::GetModuleFileName(NULL, path, Z7_ARRAY_SIZE(path));
  if (size == 0 || size >= Z7_ARRAY_SIZE(path))
    return true;
  TCHAR *separator = path + size;
  while (separator != path && separator[-1] != TEXT('\\') && separator[-1] != TEXT('/'))
    separator--;
  *separator = 0;
  if ((separator - path) + ::lstrlen(kLicenseFileName) >= Z7_ARRAY_SIZE(path))
    return true;
  ::lstrcpy(separator, kLicenseFileName);

  #ifdef UNDER_CE
  SHELLEXECUTEINFO s;
  memset(&s, 0, sizeof(s));
  s.cbSize = sizeof(s);
  s.lpFile = path;
  ::ShellExecuteEx(&s);
  #else
  ::ShellExecute(NULL, TEXT("open"), path, NULL, NULL, SW_SHOWNORMAL);
  #endif

  return true;
}
