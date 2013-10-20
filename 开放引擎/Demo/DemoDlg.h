// TestProject2Dlg.h : ͷ�ļ�
//

#pragma once
#include "afxcmn.h"
#include "afxwin.h"


// CTestProject2Dlg �Ի���
class CTestProject2Dlg : public CDialog
{
// ����
public:
	CTestProject2Dlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_TESTPROJECT2_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	HMODULE m_hMod;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedCancel();
	afx_msg void OnBnClickedButtonOpenFileDialog();
	afx_msg void OnBnClickedButtonDownload();
	afx_msg void OnBnClickedButtonStop();
	afx_msg void OnTimer(UINT nIDEvent);

	LONG    m_lTaskId;
	BOOL    m_bDownloading;
	CString m_strUrl;
	CString m_strRefUrl;
	CString m_strPath;
	CString m_strFileName;
	CProgressCtrl m_ctrlProgress;

	UINT_PTR  m_uTimerIdForQuery;
	UINT      m_uElapseForQuery;
	CStatic m_textProgress;
	afx_msg void OnBnClickedButtonPause();
	afx_msg void OnBnClickedButtonContinue();
};
