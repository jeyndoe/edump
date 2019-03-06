// A loader for Armadillo Protected "Pinch v2.58" (DEMO SOURCE CODE, NOT WORKING VERSION)
// Coded by arnix [arnix@freenet.am] -----------
// ----------------------------------------------
// What is it? OK, I've had a program and registration
// information for some other computer, the program
// is protected with Armadillo v4.?? and the registration
// information can be used only for that computer,
// because it's connected with computer's hardware ID.
// I had the name, registration code and the hardware
// ID, but I couldn't register it on my computer, so
// I decided to write this loader to force Armadillo to
// "think" that my computer's hardware ID is the same
// as I have had. If you want to use this source code
// for some other application you must:
// 1. Edit the string commented by "change me 1" and
//    write there the hardware ID that you have;
// 2. Edit the string commented by "change me 2" and
//    write there the executable's name;
// 3. Edit the string commented by "change me 3" and
//    write there the registration name;
// 4. Edit the string commented by "change me 4" and
//    write there the registration code;
// 5. Compile the source code, it has been successfully
//    compiled with "Watcom C/C++ Compiler v1.3" and
//    with "lcc-win32" (March 10, 2005 Release);

//
// WARNING: I have changed all registration information in
//          this public release! This is not a warez!

// Last updated: September 29, 2005 by arnix

#include <windows.h>
#include <stdio.h>

#define HARDWARE_ID     0x12345678      // change me 1 (0x12345678 is for 1234-5678 hardware ID)
#define PAGE_START      0x00C00000
#define PAGE_END        0x00C17FFFF
#define APP_NAME        "Builder.exe"   // change me 2

int main()
{
        STARTUPINFO SI = {0};
        PROCESS_INFORMATION PI = {0};
        char szSRTSmartDlg[] = "SRTSmartDlg";
        char szKeyRequired[] = "Key Required";
        char szButton[] = "Button";
        char szOK[] = "OK";
        char szYes[] = "&Yes";
        char szName[] = "Some name here...";      // change me 3
        char szCode[] = "123456-123456-123456-123456-123456-123456-123456-123456-123456-123456";        //change me 4
        char szEnterKey[] = "Enter Key";
        char szEdit[] = "Edit";
        char buf[50];
        char sig[9];
        unsigned origsig,usig,l;
        HWND h, h2, h3;
        BYTE b, tb;

        ZeroMemory(buf, 50);
        ZeroMemory(sig, 9);
        ZeroMemory(&SI, sizeof(STARTUPINFO));
        ZeroMemory(&PI, sizeof(PROCESS_INFORMATION));

        printf("Hello there, this is a loader for Pinch v2.58 (DEMO, NOT WORKING VERSION OF LOADER!)...\n\rCreated by arnix [arnix@freenet.am]\n\r\n\r");
        Sleep(4000);

        SI.cb = sizeof(STARTUPINFO);

        if (!CreateProcess(APP_NAME, NULL, NULL, NULL, FALSE, 0, 0, 0, &SI, &PI)) {
                printf("Error...");
                Sleep(3000);
                return 1;
        }
        Sleep(2000);
        while(1) {
                h = FindWindow((LPCTSTR) szSRTSmartDlg, (LPCTSTR) szKeyRequired);
                if (h != NULL) break;
        }

        while(1) {
                h2 = FindWindowEx(h, NULL, (LPCTSTR) szButton, (LPCTSTR) szOK);
                if (h2 != NULL) break;
                h2 = FindWindowEx(h, NULL, (LPCTSTR) szButton, (LPCTSTR) szYes);
                if (h2 != NULL) break;
        }

        SendMessage(h2, BM_CLICK, 0, 0);

        while(1) {
                h = FindWindow(NULL, (LPCTSTR) szEnterKey);
                if (h != NULL) break;
        }

        while(1) {
                h2 = FindWindowEx(h, NULL, (LPCTSTR) szEdit, NULL);
                if (h2 != NULL) break;
        }

        SendMessage(h2, WM_SETTEXT, 0, (LPARAM)(LPCTSTR) szName);

        while(1) {
                h3 = FindWindowEx(h, h2, (LPCTSTR) szEdit, NULL);
                if (h3 != NULL) break;
        }

        SendMessage(h3, WM_SETTEXT, 0, (LPARAM)(LPCTSTR) szCode);

        while(1) {
                h2 = FindWindowEx(h, h3, (LPCTSTR) szEdit, NULL);
                if (h2 != NULL) break;
        }

        l = SendMessage(h2, WM_GETTEXTLENGTH, 0, 0);
        if (l > 49) return 1;
        SendMessage(h2, WM_GETTEXT, l+1, (long int) buf);
        memcpy(&buf[0], (void*)((char*)buf+l-9), 4);
        memcpy(&buf[4], (void*)((char*)buf+l-4), 4);
        sscanf(buf, "%X", &origsig);
        memcpy(&b, &origsig, 1);

        usig = PAGE_START;
        while(1) {
                if (usig > PAGE_END) return 1;
                ReadProcessMemory(PI.hProcess, (void*)usig++, &tb, 1, NULL);
                if (tb == b) {
                        l = 0;
                        ReadProcessMemory(PI.hProcess, (void*)(usig-1), &l, 4, NULL);
                        if (l = origsig) break;
                }
        }
        l = usig-1;
        usig = HARDWARE_ID;
        WriteProcessMemory(PI.hProcess, (void*) l, &usig, 4, NULL);
        SendMessage(FindWindowEx(h, 0, (LPCTSTR) szButton, (LPCTSTR) szOK), BM_CLICK, 0, 0);
        Sleep(1000);
        return 0;
}

