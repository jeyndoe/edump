{$H+}  {$ALIGN OFF}
unit PE_Files;
interface
uses Windows;

type
  P_DWord = ^DWord;
  P_Word  = ^Word;
  DWord   = Cardinal;

  P_DOS_HEADER = ^T_DOS_HEADER;
  T_DOS_HEADER = packed record    { DOS .EXE header }
{00}   e_magic         : WORD;    { Magic number }
{02}   e_cblp          : WORD;    { Bytes on last page of file }
{04}   e_cp            : WORD;    { Pages in file }
{06}   e_crlc          : WORD;    { Relocations }
{08}   e_cparhdr       : WORD;    { Size of header in paragraphs }
{0A}   e_minalloc      : WORD;    { Minimum extra paragraphs needed }
{0C}   e_maxalloc      : WORD;    { Maximum extra paragraphs needed }
{0E}   e_ss            : WORD;    { Initial (relative) SS value }
{10}   e_sp            : WORD;    { Initial SP value }
{12}   e_csum          : WORD;    { Checksum }
{14}   e_ip            : WORD;    { Initial IP value }
{16}   e_cs            : WORD;    { Initial (relative) CS value }
{18}   e_lfarlc        : WORD;    { File address of relocation table }
{1A}   e_ovno          : WORD;    { Overlay number }
{1C}   e_res           : packed array[0..3] of Word; { Reserved words }
{24}   e_oemid         : WORD;    { OEM identifier (for e_oeminfo) }
{26}   e_oeminfo       : WORD;    { OEM information; e_oemid specific }
{28}   e_res2          : packed array[0..9] of Word; { Reserved words }
{3C}   e_lfanew        : DWord;   { File address of new exe header }
  end;

  P_PE_Header = ^T_PE_Header;
  T_PE_Header = packed record
{ 00 }   Signature               : DWord;
{ 04 }   CPU_Type                : Word;
{ 06 }   Number_Of_Object        : Word;
{ 08 }   Time_Date_Stamp         : DWord;
{ 0C }   Ptr_to_COFF_Table       : DWord;
{ 10 }   COFF_table_size         : DWord;
{ 14 }   NT_Header_Size          : Word;
{ 16 }   Flags                   : Word;
{ 18 }   Magic                   : Word;
{ 1A }   Link_Major              : Byte;
{ 1B }   Link_Minor              : Byte;
{ 1C }   Size_Of_Code            : DWord;
{ 20 }   Size_Of_Init_Data       : DWord;
{ 24 }   Size_Of_UnInit_Data     : DWord;
{ 28 }   Entry_Point_RVA         : DWord;
{ 2C }   Base_Of_Code            : DWord;
{ 30 }   Base_Of_Data            : DWord;
{ 34 }   Image_Base              : DWord;
{ 38 }   Object_Align            : DWord;
{ 3C }   File_Align              : DWord;
{ 40 }   OS_Major                : Word;
{ 42 }   OS_Minor                : Word;
{ 44 }   User_Major              : Word;
{ 46 }   User_Minor              : Word;
{ 48 }   SubSystem_Major         : Word;
{ 4A }   SubSystem_Minor         : Word;
{ 4C }   Reserved_1              : DWord;
{ 50 }   Image_Size              : DWord;
{ 54 }   Header_Size             : DWord;
{ 58 }   File_CheckSum           : DWord;
{ 5C }   SubSystem               : Word;
{ 5E }   DLL_Flags               : Word;
{ 60 }   Stack_Reserve_Size      : DWord;
{ 64 }   Stack_Commit_Size       : DWord;
{ 68 }   Heap_Reserve_Size       : DWord;
{ 6C }   Heap_Commit_Size        : DWord;
{ 70 }   Loader_Flags            : DWord;
{ 74 }   Number_of_RVA_and_Sizes : DWord;
{ 78 }   Export_Table_RVA        : DWord;
{ 7C }   Export_Data_Size        : DWord;
{ 80 }   Import_Table_RVA        : DWord;
{ 84 }   Import_Data_Size        : DWord;
{ 88 }   Resource_Table_RVA      : DWord;
{ 8C }   Resource_Data_Size      : DWord;
{ 90 }   Exception_Table_RVA     : DWord;
{ 94 }   Exception_Data_Size     : DWord;
{ 98 }   Security_Table_RVA      : DWord;
{ 9C }   Security_Data_Size      : DWord;
{ A0 }   Fix_Up_Table_RVA        : DWord;
{ A4 }   Fix_Up_Data_Size        : DWord;
{ A8 }   Debug_Table_RVA         : DWord;
{ AC }   Debug_Data_Size         : DWord;
{ B0 }   Image_Description_RVA   : DWord;
{ B4 }   Desription_Data_Size    : DWord;
{ B8 }   Machine_Specific_RVA    : DWord;
{ BC }   Machine_Data_Size       : DWord;
{ C0 }   TLS_RVA                 : DWord;
{ C4 }   TLS_Data_Size           : DWord;
{ C8 }   Load_Config_RVA         : DWord;
{ CC }   Load_Config_Data_Size   : DWord;
{ D0 }   Bound_Import_RVA        : DWord;
{ D4 }   Bound_Import_Size       : DWord;
{ D8 }   IAT_RVA                 : DWord;
{ DC }   IAT_Data_Size           : DWord;
{ E0 }   Reserved_3              : array[1..8] of Byte;
{ E8 }   Reserved_4              : array[1..8] of Byte;
{ F0 }   Reserved_5              : array[1..8] of Byte;
  end;

  T_Object_Name =  array[0..7] of Char;

type
  P_Object_Entry = ^T_Object_Entry;
  T_Object_Entry = packed record
{ 00 }  Object_Name     : T_Object_Name;
{ 08 }  Virtual_Size    : DWord;
{ 0C }  Section_RVA     : DWord;
{ 10 }  Physical_Size   : DWord;
{ 14 }  Physical_Offset : DWord;
{ 18 }  Reserved        : array[1..$0C] of Byte;
{ 28 }  Object_Flags    : DWord;
  end;

  P_Resource_Directory_Table = ^T_Resource_Directory_Table;
  T_Resource_Directory_Table = packed record
{ 00 }  Flags            : DWord;
{ 04 }  Time_Date_Stamp  : DWord;
{ 08 }  Major_Version    : Word;
{ 0A }  Minor_Version    : Word;
{ 0C }  Name_Entry       : Word;
{ 0E }  ID_Number_Entry  : Word;
  end;

  P_Resource_Entry_Item = ^T_Resource_Entry_Item;
  T_Resource_Entry_Item = packed record
    Name_RVA_or_Res_ID       : DWord;
    Data_Entry_or_SubDir_RVA : DWord;
  end;

  P_Resource_Entry = ^T_Resource_Entry;
  T_Resource_Entry = packed record
{ 00 }  Data_RVA     : DWord;
{ 04 }  Size         : DWord;
{ 08 }  CodePage     : DWord;
{ 0C }  Reserved     : DWord;
  end;

  P_Export_Directory_Table = ^T_Export_Directory_Table;
  T_Export_Directory_Table = packed record
{ 00 }  Flags                     : DWord;
{ 04 }  Time_Date_Stamp           : DWord;
{ 08 }  Major_Version             : Word;
{ 0A }  Minor_Version             : Word;
{ 0C }  Name_RVA                  : DWord;
{ 10 }  Ordinal_Base              : DWord;
{ 14 }  Number_of_Functions       : DWord;
{ 18 }  Number_of_Names           : DWord;
{ 1C }  Address_of_Functions      : DWord;
{ 20 }  Address_of_Names          : DWord;
{ 24 }  Address_of_Ordinals       : DWord;
  end;

  P_Import_Directory_Entry = ^T_Import_Directory_Entry;
  T_Import_Directory_Entry = packed record
{ 00 }  Original_First_Thunk      : DWord;
{ 04 }  Time_Date_Stamp           : DWord;
{ 08 }  Forward_Chain             : DWord;
{ 0C }  Name_RVA                  : DWord;
{ 10 }  First_Thunk               : DWord;
  end;

const
  E_OK                  =  0;
  E_FILE_NOT_FOUND      =  1;
  E_CANT_OPEN_FILE      =  2;
  E_ERROR_READING       =  3;
  E_ERROR_WRITING       =  4;
  E_NOT_ENOUGHT_MEMORY  =  5;
  E_INVALID_PE_FILE     =  6;

  M_ERR_CAPTION         =  'PE File Error...';
  M_FILE_NOT_FOUND      =  'Can''t find file. ';
  M_CANT_OPEN_FILE      =  'Can''t open file. ';
  M_ERROR_READING       =  'Error reading file. ';
  M_ERROR_WRITING       =  'Error writing file. ';
  M_NOT_ENOUGHT_MEMORY  =  'Can''t alloc memory. ';
  M_INVALID_PE_FILE     =  'Invalid PE file. ';

  Minimum_File_Align    = $0200;
  Minimum_Virtual_Align = $1000;

{ ########################################################################## }

type
 PE_File = class(TObject)
 public
   DOS_HEADER         : P_DOS_HEADER;
   PE_Header          : P_PE_Header;
   LastError          : DWord;
   ShowDebugMessages  : Boolean;
   pMap               : Pointer;
   PreserveOverlay    : Boolean;
   IsDLL              : Boolean;
   File_Size          : DWord;
   OverlayData        : Pointer;
   OverlaySize        : DWord;
   constructor Create;
   destructor  Destroy; override;
   procedure   LoadFromFile(FileName: String);
   procedure   SaveToFile(FileName: String);
   procedure   FlushFileCheckSum;
   procedure   OptimizeHeader(WipeJunk: Boolean);
   procedure   OptimizeFileAlignment;
   procedure   FlushRelocs(ProcessDll: Boolean);
   procedure   OptimizeFile(AlignHeader,WipeJunk,KillRelocs,KillInDll: Boolean);
 private
   PObject     : P_Object_Entry;
   Data_Size   : DWord;
   function    IsPEFile(pMap: Pointer): Boolean;
   procedure   DebugMessage(MessageText: String);
   procedure   GrabInfo;
   function    IsAlignedTo(Offs, AlignTo: DWord): Boolean;
   function    AlignBlock(Start: Pointer; Size: DWord; AlignTo: DWord): DWord;
 end;

{ ########################################################################## }

implementation

constructor PE_File.Create;
begin
  inherited Create;
  LastError := E_OK;
  ShowDebugMessages := false;
  DOS_HEADER := nil;
  PE_Header  := nil;
  pMap  := nil;
  IsDLL := false;
  File_Size := 0;
  Data_Size := 0;
  PreserveOverlay := false;
  OverlayData     := nil;
  OverlaySize     := 0;
end;

destructor PE_File.Destroy;
begin
  if pMap <> nil then FreeMem(pMap);
  if OverlayData <> nil then FreeMem(OverlayData);
  inherited Destroy;
end;

{ +===========================================+ }
{ | Just show MessageBox with custom message. | }
{ +===========================================+ }
procedure PE_File.DebugMessage(MessageText: String);
begin
  MessageBox(0, PChar(MessageText), M_ERR_CAPTION, MB_OK or MB_ICONSTOP);
end;

{ +=============================================+ }
{ | Validate is mapped file PE or not.          | }
{ | Result is true if it is real PE Image.      | }
{ +=============================================+ }
function PE_File.IsPEFile(pMap: Pointer): Boolean;
var
  DOS_Header : P_DOS_Header;
  PE_Header  : P_PE_Header;
begin
  Result := false;
  if pMap = nil then Exit;
  DOS_Header := pMap;
  if DOS_Header.e_magic <> $5A4D  {'MZ'} then Exit;         // Not executable.
  if (DOS_Header.e_lfanew < $40) or (DOS_Header.e_lfanew > $F08) then Exit;
  PE_Header  := Pointer(DOS_Header.e_lfanew + DWord(pMap));
  if PE_Header.Signature <> $4550 {'PE'} then Exit;         // Not PE file.
  Result := true;
end;

{ +=======================================+ }
{ | Grab some information from PE header. | }
{ +=======================================+ }
procedure PE_File.GrabInfo;
var
  I : Integer;
begin
  if (PE_Header.Flags and $2000) = 0 then IsDLL := false else IsDLL := true;

  Data_Size := PE_Header^.Header_Size;
  if PE_Header.Number_Of_Object > 0 then begin
    PObject := Pointer(DWord(PE_Header) + SizeOf(T_PE_Header));
    for I := 1 to PE_Header.Number_Of_Object do begin
      if (PObject.Physical_Offset > 0) and (PObject.Physical_Size > 0) then
        Inc(Data_Size, PObject.Physical_Size);
      Inc(DWord(PObject), SizeOf(T_Object_Entry));
    end;
  end;
end;

{ +======================================================+ }
{ | Load PE file to memory and create it's mapped image. | }
{ +======================================================+ }
procedure PE_File.LoadFromFile(FileName: String);
var
  Header    : Pointer;
  hFile     : DWord;
  Readed, I : DWord;
  FindData  : _WIN32_FIND_DATAA;
begin
  if FindFirstFile(PChar(FileName), FindData) = INVALID_HANDLE_VALUE then begin
    LastError := E_FILE_NOT_FOUND;
    if ShowDebugMessages then DebugMessage(M_FILE_NOT_FOUND + FileName);
    Exit;
  end;

  hFile := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ, nil,
                      OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if hFile = INVALID_HANDLE_VALUE then begin
    LastError := E_CANT_OPEN_FILE;
    if ShowDebugMessages then DebugMessage(M_CANT_OPEN_FILE + FileName);
    Exit;
  end;

  GetMem(Header, $1000);
  if Header = nil then begin
    LastError := E_NOT_ENOUGHT_MEMORY;
    if ShowDebugMessages then DebugMessage(M_NOT_ENOUGHT_MEMORY);
    Exit;
  end;

  ReadFile(hFile, Header^, $1000, Readed, nil);
  if (Readed < $200) or (not IsPEFile(Header)) then begin
    LastError := E_INVALID_PE_FILE;
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    CloseHandle(hFile);
    FreeMem(Header);
    Exit;
  end;

  DOS_Header := Header;
  PE_Header  := Pointer(DOS_Header.e_lfanew + DWord(Header));

  if pMap <> nil then FreeMem(pMap);
  if OverlayData <> nil then FreeMem(OverlayData);

  GetMem(pMap, PE_Header.Image_Size);
  if pMap = nil then begin
    LastError := E_NOT_ENOUGHT_MEMORY;
    if ShowDebugMessages then DebugMessage(M_NOT_ENOUGHT_MEMORY);
    CloseHandle(hFile);
    FreeMem(Header);
    Exit;
  end;

  FillChar(pMap^, PE_Header.Image_Size, 0);
  Move(Header^, pMap^, PE_Header.Header_Size);
  FreeMem(Header);

  DOS_Header := pMap;
  PE_Header  := Pointer(DOS_Header.e_lfanew + DWord(pMap));

  PObject := Pointer(DWord(PE_Header) + SizeOf(T_PE_Header));
  for I := 1 to PE_Header.Number_Of_Object do begin    // Correct header size.
    if PE_Header.Header_Size > PObject.Section_RVA then
      PE_Header.Header_Size := PObject.Section_RVA;
    Inc(DWord(PObject), SizeOf(T_Object_Entry));
  end;

  GrabInfo;

  File_Size := GetFileSize(hFile, nil);
  if (PreserveOverlay = true) and (File_Size > Data_Size) then begin
    OverlaySize := File_Size - Data_Size;                  // Process overlay.
    GetMem(OverlayData, OverlaySize);
    if OverlayData = nil then begin
      LastError := E_NOT_ENOUGHT_MEMORY;
      if ShowDebugMessages then DebugMessage(M_NOT_ENOUGHT_MEMORY);
      CloseHandle(hFile);
      Exit;
    end;
    SetFilePointer(hFile, Data_Size, nil, FILE_BEGIN);
    ReadFile(hFile, OverlayData^, OverlaySize, Readed, nil);
  end;

  if PE_Header.Number_Of_Object = 0 then begin
    LastError := E_OK;
    CloseHandle(hFile);
    Exit;
  end;

  PObject := Pointer(DWord(PE_Header) + SizeOf(T_PE_Header));
  for I := 1 to PE_Header.Number_Of_Object do begin
    if (PObject.Physical_Offset = 0) and (PObject.Physical_Size <> 0) then
    begin
      { Correct header for ADA and Watcom C++ compiler's }
      PObject.Virtual_Size  := PObject.Physical_Size;
      PObject.Physical_Size := 0;
    end;
    if (PObject.Physical_Offset > 0) and (PObject.Physical_Size > 0) then begin
      SetFilePointer(hFile, PObject.Physical_Offset, nil, FILE_BEGIN);
      ReadFile(hFile, Pointer(DWord(pMap) + PObject.Section_RVA)^,
               PObject.Physical_Size, Readed, nil);
      if Readed <> PObject.Physical_Size then begin
        LastError := E_ERROR_READING;
        if ShowDebugMessages then DebugMessage(M_ERROR_READING + FileName);
        CloseHandle(hFile);
        Exit;
      end;
    end;
    Inc(DWord(PObject), SizeOf(T_Object_Entry));
  end;

  CloseHandle(hFile);
  LastError := E_OK;
end;

{ +===============================+ }
{ | Save mapped image of PE file. | }
{ +===============================+ }
procedure PE_File.SaveToFile(FileName: String);
var
  I       : DWord;
  hFile   : DWord;
  Written : DWord;
begin
  if (pMap = nil) or (not IsPEFile(pMap)) then begin
    LastError := E_INVALID_PE_FILE;
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    Exit;
  end;

  hFile := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE,
                      FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                      CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if hFile = INVALID_HANDLE_VALUE then begin
    LastError := E_CANT_OPEN_FILE;
    if ShowDebugMessages then DebugMessage(M_CANT_OPEN_FILE + FileName);
    Exit;
  end;

  File_Size := PE_Header.Header_Size;

  SetFilePointer(hFile, 0, nil, FILE_BEGIN);                 // Save header.
  if (not WriteFile(hFile, pMap^, PE_Header.Header_Size, Written, nil)) or
     (Written <> PE_Header.Header_Size) then
  begin
    LastError := E_ERROR_WRITING;
    if ShowDebugMessages then DebugMessage(M_ERROR_WRITING + FileName);
    CloseHandle(hFile);
    Exit;
  end;

  if PE_Header.Number_Of_Object > 0 then begin         // Save PE Sections.
    PObject := Pointer(DWord(PE_Header) + SizeOf(T_PE_Header));
    for I := 1 to PE_Header.Number_Of_Object do begin     // Copy Sections.
      if (not WriteFile(hFile, Pointer(DWord(pMap) + PObject.Section_RVA)^,
                        PObject.Physical_Size, Written, nil)) or
         (Written <> PObject.Physical_Size) then
      begin
        LastError := E_ERROR_WRITING;
        if ShowDebugMessages then DebugMessage(M_ERROR_WRITING + FileName);
        CloseHandle(hFile);
        Exit;
      end;
      Inc(File_Size, PObject.Physical_Size);
      Inc(DWord(PObject), SizeOf(T_Object_Entry));
    end;
  end;

  if (PreserveOverlay = true) and (OverlaySize > 0) then begin
    Inc(File_Size, OverlaySize);
    SetFilePointer(hFile, 0, nil, FILE_END);                  // Save overlay.
    WriteFile(hFile, OverlayData^, OverlaySize, Written, nil);
  end;

  CloseHandle(hFile);
  LastError := E_OK;
end;

{ +=========================================+ }
{ | Test is Offs aligned to AlignTo or not. | }
{ +=========================================+ }
function PE_File.IsAlignedTo(Offs, AlignTo: DWord): Boolean;
begin
  if (Offs mod AlignTo) = 0 then Result := true else Result := false;
end;

{ +===============================================================+ }
{ | Try to remove zero padding from block (Start - blocks offset; | }
{ | Size - size of block in bytes) and realign block to 200h.     | }
{ | Return new block size.                                        | }
{ +===============================================================+ }
function PE_File.AlignBlock(Start: Pointer; Size: DWord; AlignTo: DWord): DWord;
var
  P : ^Byte;
begin
  Result := 0;
  if Size = 0 then Exit;
  P := Pointer(DWord(Start) + Size - 1);       // Set pointer to end of block.
                                               // Find first non-zero byte.
  while (P^ = 0) and (DWord(P) > DWord(Start)) do Dec(DWord(P));
  if (DWord(P) = DWord(Start)) and (P^ = 0) then Exit;  // Block is empty.
                                                        // Find new alignment.
  while (not IsAlignedTo(DWord(P) - DWord(Start), AlignTo)) and
        (DWord(P) < (DWord(Start) + Size)) do Inc(DWord(P));

  Result := DWord(P) - DWord(Start);
end;

{ +======================================================+ }
{ |  Optimize position of PE header, clear junk from it  | }
{ |  and realign header to minimum safe alignment (200h) | }
{ +======================================================+ }
procedure PE_File.OptimizeHeader(WipeJunk: Boolean);
var
  AllObjSize : DWord;
  NewHdrSize : DWord;
  HdrSize, I : DWord;
  NewHdrOffs : ^Word;
begin
  if (pMap = nil) or (not IsPEFile(pMap)) then begin
    LastError := E_INVALID_PE_FILE;
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    Exit;                                           // Not PE File - aborting.
  end;

  NewHdrOffs := Pointer(DWord(pMap) + $40);  // 40h - minimum posible offset.

  while ((NewHdrOffs^ <> 0) or               // Search new place for PE Header.
         (not IsAlignedTo(DWord(NewHdrOffs) - DWord(pMap), 16)) and
        (DWord(NewHdrOffs) < DWord(PE_Header)) ) do Inc(DWord(NewHdrOffs));

                                               // Save size of Object Table.
  AllObjSize := PE_Header.Number_Of_Object * SizeOf(T_Object_Entry);

  if (DWord(NewHdrOffs) - DWord(pMap)) < DOS_Header^.e_lfanew then
  begin                                             // Save new header offset.
    DOS_Header.e_lfanew := DWord(NewHdrOffs) - DWord(pMap);
                                                               // Copy header.
    Move(PE_Header^, NewHdrOffs^, SizeOf(T_PE_Header) + AllObjSize);
    PE_Header := Pointer(NewHdrOffs);

    if WipeJunk = false then                      // Clear junk after objects.
      FillChar(Pointer(DWord(NewHdrOffs) + SizeOf(T_PE_Header) + AllObjSize)^,
               DWord(PE_Header) - DWord(NewHdrOffs), 0);
  end;

  if WipeJunk = true then begin                    // Get actual header size.
    HdrSize := DOS_Header.e_lfanew + SizeOf(T_PE_Header) + AllObjSize;
                                                               // Clear junk.
    FillChar(Pointer(DWord(pMap) + HdrSize)^, PE_Header.Header_Size-HdrSize, 0);
    if (PE_Header.Bound_Import_RVA  <> 0) or
       (PE_Header.Bound_Import_Size <> 0) then
    begin                                  // Remove Bound Import descriptor.
      PE_Header.Bound_Import_RVA  := 0;
      PE_Header.Bound_Import_Size := 0;
    end;
  end;
                                                   // Calculata opimized size.
  NewHdrSize := AlignBlock(pMap, PE_Header.Header_Size, Minimum_File_Align);

  if NewHdrSize < PE_Header.Header_Size then begin
    if PE_Header.Number_Of_Object > 0 then begin
      PObject := Pointer(DWord(PE_Header) + SizeOf(T_PE_Header));
      for I := 1 to PE_Header.Number_Of_Object do begin    // Update offsets.
        Dec(PObject.Physical_Offset, PE_Header.Header_Size - NewHdrSize);
        Inc(DWord(PObject), SizeOf(T_Object_Entry));
      end;
    end;
    PE_Header.Header_Size := NewHdrSize;             // Save new header size.
  end;

  LastError := E_OK;
end;

{ +==============================================+ }
{ | Fill relocations of mapped PE File by zero.  | }
{ +==============================================+ }
procedure PE_File.FlushRelocs(ProcessDll: Boolean);
begin
  if (pMap = nil) or (not IsPEFile(pMap)) then begin
    LastError := E_INVALID_PE_FILE;
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    Exit;                                           // Not PE File - aborting.
  end;

  LastError := E_OK;
  if (not ProcessDll) and (IsDLL = true) then Exit; // It's DLL - Skipping.

  if (PE_Header.Fix_Up_Table_RVA = 0) or
     (PE_Header.Fix_Up_Data_Size = 0) then Exit;  // No relocations.
                                                  // Fill relocations by zero.
  FillChar(Pointer(DWord(pMap) + PE_Header^.Fix_Up_Table_RVA)^,
           PE_Header^.Fix_Up_Data_Size, 0);

  PE_Header^.Fix_Up_Table_RVA := 0;                      // Update header.
  PE_Header^.Fix_Up_Data_Size := 0;
end;

{ +=======================================+ }
{ |  Realign mapped PE file to 0200h and  | }
{ |  remove empty sections.               | }
{ |  Procedure don't optimize header      | }
{ +=======================================+ }
procedure PE_File.OptimizeFileAlignment;
var
  OldSize  : DWord;
  NewSize  : DWord;
  LastOffs : DWord;
  I        : Integer;
begin
  if (pMap = nil) or (not IsPEFile(pMap)) then begin
    LastError := E_INVALID_PE_FILE;
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    Exit;                                           // Not PE File - aborting.
  end;

  LastError := E_OK;

  PE_Header.File_Align := Minimum_File_Align;
  if PE_Header.Number_Of_Object = 0 then Exit;                // No sections.

  LastOffs := PE_Header.Header_Size;          // Maximum RAW offset.
                                              // Optimize sections alignment.
  PObject := Pointer(DWord(PE_Header) + SizeOf(T_PE_Header));
  for I := 1 to PE_Header.Number_Of_Object do begin
    if (PObject.Physical_Size > 0) and (PObject^.Physical_Offset >=  LastOffs)
    then begin
      OldSize := PObject.Physical_Size;
      NewSize := AlignBlock(Pointer(DWord(pMap) + PObject.Section_RVA),
                            PObject.Physical_Size, Minimum_File_Align);
      if NewSize < OldSize then PObject.Physical_Size := NewSize;
    end;
    PObject.Physical_Offset := LastOffs;      // Update sections RAW offset.
    Inc(LastOffs, PObject.Physical_Size);
    Inc(DWord(PObject), SizeOf(T_Object_Entry));
  end;
end;

{ +=====================================+ }
{ | Set internal file SheckSum to zero. | }
{ +=====================================+ }
procedure PE_File.FlushFileCheckSum;
begin
  PE_Header.File_CheckSum := 0;
end;

{ +===========================================+ }
{ | Optimize file image by all known methods. | }
{ +===========================================+ }
procedure PE_File.OptimizeFile(AlignHeader : Boolean;
                               WipeJunk    : Boolean;
                               KillRelocs  : Boolean;
                               KillInDll   : Boolean);
begin
  if (pMap = nil) or (not IsPEFile(pMap)) then begin
    LastError := E_INVALID_PE_FILE;
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    Exit;                                           // Not PE File - aborting.
  end;

  if AlignHeader then begin
    OptimizeHeader(WipeJunk);
    if LastError <> E_OK then begin
      if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
      Exit;
    end;
  end;

  if KillRelocs then begin
    FlushRelocs(KillInDll);
    if LastError <> E_OK then begin
      if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
      Exit;
    end;
  end;

  OptimizeFileAlignment;
  if LastError <> E_OK then begin
    if ShowDebugMessages then DebugMessage(M_INVALID_PE_FILE);
    Exit;
  end;

  FlushFileCheckSum; 
end;

{ ########################################################################## }

begin
end.
