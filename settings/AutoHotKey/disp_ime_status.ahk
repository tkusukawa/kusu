/* 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 "�Ȃ܂�IME"
 disp_ime_status.ahk
   IME��Ԃ��L�����b�g�t�߂ɕ\������B
   �ڍׂ́A
   http://www.tierra.ne.jp/~aki/diary/?date=20051204#p01
   ���Q�Ƃ��Ă��������B

   ver1.02.01   05/12/16
   �Ȃ܂�

 �����̃v���O�����͂Ȃ܂��̒��앨�ł����A��������ς͎��R�ɍs���Ă���������
   ���\�ł��B�܂��A�ĔЕz(���O���M)�⏤�Ɨ��p���܂ޏ��n���A�u�Ȃ܂��v�̖��O�ƁA
   URL(http://www.tierra.ne.jp/~aki/diary/)��Y���Ă���������΁A�����R��
   ���Ă��������Č��\�ł��B���ς������̂��ĔЕz(���O���M)����n����ꍇ�́A
   ���ς����|��\�L���Ă��������B
 �����̃v���O�����𗘗p���Đ����������Ȃ鑹�Q�ɑ΂��Ă��A�Ȃ܂��͐ӔC�𕉂���
   ����B�������炸���������������B

 �ύX����
 
 ver1.02.01   05/12/16
   grid�����������W�ɏo�Ȃ��o�O������A�Ή������B

 ver1.02.00   05/12/14
   ���O��t�����B
   �g���C�A�C�R�����̃A�v�����̃f�t�H���g��ύX�B
   �����[�h���Ƀ��j���[���ڂ��ύX�ł��Ȃ������̂őΏ�
   �\���p�����[�^frameType��ǉ�
   �����[�h�ƏI�����w�肷�郁�b�Z�[�W����M�ł���悤�ɂ����B

 ver1.01.00   05/12/9
   �\���̑傫����F�A�t�H���g��ύX�ł���悤�ɁA�\���p�����[�^�𑝂₵���B
   ����ɁAini�t�@�C���ł킩��Ղ��p�����[�^�w�肪�ł���悤�ɁAini�t�@�C����
   �l�Œ���IME��Ԃ̕]����\��������̂ł͂Ȃ��A�����Ŏg�p����l�̌`�ɕϊ�����
   ����]����\��������悤�ɂ����B���̂��߂ɁA�\���p�����[�^�ƁA�����p�����[�^
   ��API��ǉ������B

 ver1.00.01   05/12/5
   �^�C�}�N���Ԋu��500msec�ȏ�ɂ��Ȃ��ƁAIE�̉摜�̃c�[���`�b�v���o�Ȃ��Ȃ�
   �Ƃ������̑Ώ�
   �P�ƃA�v���̏ꍇ�́ACAR_GetCaretPos()�Ɏw�����āA��ɋ��L��Ԃ��ێ����A
   AttachThreadInput�����炵�ĕ��ׂ����炷�悤�ɂ����B
   ��L�ɔ����A�N���b�N���ɂ́ACAR_GetCaretPos()�Ƀ��Z�b�g���w�����āA
   ���L��Ԃ�\��Ȃ����悤�ɂ����B

 ver1.00.00   05/11/30
   �ŏ��̃o�[�W����

 ���W���[���\��
 
 1.�P�ƃA�v���p��������
   �P�Ƃ̏풓�A�v���Ƃ��ē��삳���鎞�̂��߂̏������B�N���b�N�̃t�b�N��
   �^�X�N�g���C�A�C�R���̃��j���[�ȂǁB
   autohotkey.ini�ɑg�ݍ��ޏꍇ�́A�X�L�b�v�����B
   
 2.�f�t�H���g�l�Ǘ���
   �f�t�H���g�l���Ǘ�����B
   �{�A�v���Ŏg�p����l�́A�ȉ��̃V�X�e���Ǘ����Ȃǂ̊e��Ǘ����œƗ����ĊǗ�
   ����邪�A���ꂾ�ƁA�f�t�H���g�l��ύX����Ƃ��ɁA���������Ή�����Ǘ�����
   ��`����T���Ȃ���΂Ȃ炸�A�ʓ|�B
   �����ŁA�f�t�H���g�l�Ǘ����ł́A�e��̊Ǘ����ŊǗ�����l�̃f�t�H���g�l�������A
   �ȒP�Ƀf�t�H���g�l��ݒ�ł���悤�ɂ��Ă���B
   �e�Ǘ����́A���������ɁA���̃f�t�H���g�l�Ǘ����ɁA�f�t�H���g�l����`�����
   ���邩�ǂ��������ˁA��`���������炻����g���A�Ȃ�������A���O�Ńf�t�H���g�l��
   �ݒ肷��B������A�e�Ǘ������Ǘ�����l�̂��ׂẴf�t�H���g�l��
   ���̃f�t�H���g�l�Ǘ��������̂ł͂Ȃ��A��\�I�Ȃ��̂��������Ă���B
   
 3.�V�X�e���Ǘ���
   �{�A�v���̏������A���C�����[�`��(�^�C�}�n���h��)�A�����[�h�A�I�������A
   �V�X�e���p�����[�^�̊Ǘ������s���B
   
 4.ini�t�@�C���ǂݏo����
   �ݒ��`�p��ini�t�@�C������p�����[�^��ǂݏo���B
   
 5.�����Ǘ���
   ini�t�@�C������͂��Đe�q�֌W����ǂݏo���A�Ǘ�����B
   IME��ԓ��ɉ����ď����𖞂����Z�N�V���������肵�A�p�����[�^�ݒ������B
   
 6.�\���Ǘ���
   IME��ԕ\���p�̕\���p�����[�^�̊Ǘ��ƁA���̕\�����s���B
   
 (7.�L�����b�g�֌W)
   caret.ahk��include�B
   �L�����b�g���W�����o���B
   
 (8.ini�t�@�C���Ǘ���)
   ini_file.ahk��include�B
   ini�t�@�C���̓ǂݏo���ƁA���@����
   
 �ړ���
   DMS_
   �{�t�@�C���Œ�`���ꂽ�O���[�o����(�֐��A���x���A�O���[�o���ϐ�)�́A���ׂ�
   "DMS_"�Ƃ����ړ�������B
   
 �O���[�o���ϐ�
   �u5.�����Ǘ����v�ɂ����āA�����֐��Ԃ̎������L�ɂ��������A����у��x��
   �T�u���[�`���ƈ����Ɩ߂�l�����Ƃ肷�邽�߂ɁA�O���[�o���ϐ���p���Ă���B
   ����ȊO�͈�؃O���[�o���ϐ��͎g���Ă��Ȃ��B
   
 �ˑ��֌W(�ȉ��̃t�@�C�����K�{)
   caret.ahk
   ini_file.ahk
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/


/*
----------------------------------------------------------------------------
  1.�P�ƃA�v���p��������

   �P�Ƃ̏풓�A�v���Ƃ��ē��삳���鎞�̂��߂̏������B�N���b�N�̃t�b�N��
   �^�X�N�g���C�A�C�R���̃��j���[�ȂǁB
   autohotkey.ini�ɑg�ݍ��ޏꍇ�́A�X�L�b�v�����B

----------------------------------------------------------------------------
*/
#Persistent
  ; ������
  DMS_Init(true)

  ; �O���A�v������̃��b�Z�[�W���󂯎��E�C���h�E�̍쐬
  apiwin_num := DMS_SystemParameters("apiwin_num")
  Gui, %apiwin_num%:+AlwaysOnTop +Disabled +ToolWindow
  Gui, %apiwin_num%:Show,NoActivate,DispIMEstatusApiWindow
  OnMessage(0x5555,"DMS_MessageHandle")

  ; �_�u���N���b�N���Ώ��p�t�b�N
  ; 1.00.01�ł́A�_�u���N���b�N�Ώ��p�ł͂Ȃ��A�N���b�N�ōēxAttach����
  ; ���m�ȃL�����b�g���W�𓾂邽�߁B
  Hotkey, ~LButton, DMS_Click_Sub
  Hotkey, ~RButton, DMS_Click_Sub

  ; �g���C�A�C�R�����j���[�쐬
;  DMS_Menu()
return



/*
------------------------------------------
  7.�L�����b�g�֌W
------------------------------------------
*/
#include, caret.ahk

/*
------------------------------------------
  8.ini�t�@�C���Ǘ���
------------------------------------------
*/
#include, ini_file.ahk


/*
----------------------------------------------------------------------------
  2.�f�t�H���g�l�Ǘ���

   �f�t�H���g�l���Ǘ�����B
   �{�A�v���Ŏg�p����l�́A�ȉ��̃V�X�e���Ǘ����Ȃǂ̊e��Ǘ����œƗ����ĊǗ�
   ����邪�A���ꂾ�ƁA�f�t�H���g�l��ύX����Ƃ��ɁA���������Ή�����Ǘ�����
   ��`����T���Ȃ���΂Ȃ炸�A�ʓ|�B
   �����ŁA�f�t�H���g�l�Ǘ����ł́A�e��̊Ǘ����ŊǗ�����l�̃f�t�H���g�l�������A
   �ȒP�Ƀf�t�H���g�l��ݒ�ł���悤�ɂ��Ă���B
   �e�Ǘ����́A���������ɁA���̃f�t�H���g�l�Ǘ����ɁA�f�t�H���g�l����`�����
   ���邩�ǂ��������ˁA��`���������炻����g���A�Ȃ�������A���O�Ńf�t�H���g
   �l��ݒ肷��B������A�e�Ǘ������Ǘ�����l�̂��ׂẴf�t�H���g�l��
   ���̃f�t�H���g�l�Ǘ��������̂ł͂Ȃ��A��\�I�Ȃ��̂��������Ă���B

----------------------------------------------------------------------------
*/

/*
 ...............................................................

  �f�t�H���g�l���Ǘ�����B
  
  �f�t�H���g�l�̏�����
  DMS_Default()
    ����:   
      �Ȃ�
    �߂�l: 
      �Ȃ�
    ����:
      �f�t�H���g�l������������
  
  �f�t�H���g�l�̎��o��
  DMS_Default(paramName)
    ����:
      paramName : �p�����[�^��
    �߂�l: 
      �p�����[�^�̃f�t�H���g�l
    ����:
      paramName�Ƃ����p�����[�^�̃f�t�H���g�l�����o��

 ...............................................................
*/  
DMS_Default(method = false)
{
  static ini_file
  static string
  static ofst_x, ofst_y
  static trans
  static grid_x, grid_y
  static time
  static timeAfterClick
  static menu_reload
  static menu_end
  static title
  static gen_max
  static alwaysCaretOn
  static tooltip_num
  static normal
  static color
  static margin_x
  static margin_y
  static fontName
  static fontColor
  static fontSize
  static fontStyle
  static apiwin_num

  
  if(!method)
  {
    ; �������Ȃ������̂ŁA�f�t�H���g�l������
    ini_file := "disp_ime_status.ini"
    string := ""
    ofst_x := -18
    ofst_y := -17
    trans  := 0
    grid_x  := 0
    grid_y  := 0
    time  := 500
    timeAfterClick := 300
    menu_reload := "ini�t�@�C���ēǂݍ���(&R)"
    menu_end := "�I��(&X)"
    title := "�Ȃ܂�IME"
    gen_max := 64
    alwaysCaretOn := ""
    tooltip_num := 19
    normal := 0
    color := ""
    margin_x := 2
    margin_y := 1
    fontName := ""
    fontColor := ""
    fontSize := ""
    fontStyle := ""
    frameStyle := 1
    apiwin_num := 18
    return
  }
  else
  {
    ; �f�t�H���g�l�ǂݏo��
    ; ����`�̃f�t�H���g�l��������ANULL���A��
    content := %method%
    return content
  }
}

/*
----------------------------------------------------------------------------
  3.�V�X�e���Ǘ���

   �{�A�v���̏������A���C�����[�`��(�^�C�}�n���h��)�A�����[�h�A�I�������A
   �V�X�e���p�����[�^�̊Ǘ������s���B

----------------------------------------------------------------------------
*/

/*
 ...............................................................................

  �{�A�v���̏�����
  
  DMS_Init()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �{�A�v���̏������Bautohotkey.ini����ĂԂƂ��ɂ��̃X�^�C���ŌĂ�
      �������Ɏ��s������(ini�t�@�C���ɃG���[��������)�́A�P�Ƀ��^�[������B

  DMS_Init(independent)
    ����:   
      independent: true�Ȃ�A�Ɨ������풓�A�v���B
                   false�Ȃ�A���̃X�N���v�g�ɑg�ݍ��܂�Ă���
    �߂�l: 
      �Ȃ�
    ����:
      �{�A�v���̏������B�������Ɏ��s������(ini�t�@�C���ɃG���[��������)�́A
      independent��true�Ȃ�A�{�X���b�h���~������Bfalse�Ȃ�A�P�Ƀ��^�[������
 ...............................................................................
*/
DMS_Init(independent = false)
{
  ; �I�������̒�`
  DMS_End("init", independent)

  ; �f�t�H���g�l�̒�`
  DMS_Default()
  
  ; �V�X�e�����f�t�H���g�l�ݒ�
  DMS_SystemParameters()
  
  ; �\�����f�t�H���g�l�ݒ�
  DMS_DispParameters()

  ; �����������N���A
  DMS_CondParameters()

  ; ini�t�@�C���̓ǂݍ���
  ini_file := DMS_Default("ini_file")
  if(!DMS_ReadIniFile(ini_file, message))
  {
    DMS_End("end", message)
    return
  }

  ; �L�����b�g���W�擾���[�h�ݒ�
  CAR_GetCaretPos(false,dummy,dummy,independent)

  ; �^�C�}�֐��ݒ�
  time := DMS_SystemParameters("time")
  SetTimer, DMS_Main, %time%
  return
}

/*
 ...............................................................................

  �^�C�}�n���h��
  DMS_MainFunc()���ĂԂ���
 ...............................................................................
*/
DMS_Main:
  DMS_MainFunc()
return

/*
 ...............................................................................

  ���C�����[�`��
  
  DMS_MainFunc()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �^�C�}�n���h������Ă΂��B
      1. �܂��A�����[�h���v������Ă�����A�����[�h����
      2. �L�����b�g���o�Ă��邩�ǂ������ׂāA�o�ĂȂ�������Ȃɂ��������^�[��
      3. �L�����b�g���o�Ă�����A���݂�IME��ԓ��𒲂ׂāA�\���p�����[�^��ݒ�
      4. �\�����s��
 ...............................................................................
*/

DMS_MainFunc()
{
  ; �����[�h���v������Ă�����A�����[�h�B���s������A���^�[��
  if(!DMS_Reload_main())
    return

  ; ����̂��̊֐��̃^�C�}�ݒ���s��
  ; �����[�h�ŁA�^�C�}�Ԋu���ς������������Ȃ����AtimeAfterClick��
  ; �^�C�}�Ԋu���ύX����Ă��邩������Ȃ�����B
  time := DMS_SystemParameters("time")
  SetTimer, DMS_Main, %time%


  ; �Ƃ肠�����A�A�N�e�B�u�E�C���h�E���m�F
  WinGet, actwin, ID, A
  if(!actwin)
  {
    ; �A�N�e�B�u�E�C���h�E���Ȃ�������A�L�����b�g���o�Ă�킯�Ȃ��B
    ; �\���������ă��^�[��
    DMS_DispIMEsts(false)
    return
  }

  ; �L�����b�g���o�Ă��邩�m�F
  alwaysCaretOn := DMS_SystemParameters("alwaysCaretOn")
  if(!CAR_GetCaretPos(actwin,  car_x,car_y, alwaysCaretOn))
  {
    ; �L�����b�g���o�ĂȂ���Ε\���������ă��^�[��
    DMS_DispIMEsts(false)
    return
  }

  ; �p�����[�^�擾
  if(!DMS_SelectParameters(actwin, car_x, car_y))
  {
    DMS_DispIMEsts(false)
    return
  }

  ; IME��ԕ\��
  DMS_DispIMEsts(true)

  return
}

/*
 ...............................................................................

  �����[�h�̐ݒ�
  
  DMS_Reload()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �����[�h�\�������B�����āADMS_Main�������N��������B
      ���ۂ̃����[�h��DMS_MainFunc�̒��ōs�킹��B���ݏ������̃p�����[�^��
      �����[�h�ɂ���ĕύX����Ă��܂��ẮA�\�����ʃo�O�������N��������B
      �����炱���ł́A�\�񂾂����ă��^�[������B
 ...............................................................................
*/
DMS_Reload()
{
  ; �����[�h�\��
  DMS_Reload_main(true)
  ; �^�C�}�n���h���������N��
  SetTimer, DMS_Main, 0
}

/*
 ...............................................................................

  �����[�h�����Ɨ\��
  
  �����[�h����
  DMS_Reload_main()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �����[�h�����������Ă�����A�����[�h����B
      �����ĂȂ�������A�Ȃɂ��������^�[������B
      
  �����[�h�\��
  DMS_Reload_main(true)
    ����:
      ���true
    �߂�l:
      �Ȃ�
    ����:
      �����[�h�\������A���^�[������B����ADMS_Reload_main()���R�[�����ꂽ��A
      �����[�h���s����B
 ...............................................................................
*/

DMS_Reload_main(reloadSignal = false)
{
  static reloadFlag

  ; ������true���ǂ����`�F�b�N�Btrue�Ȃ�\��̂�
  if(reloadSignal)
  {
    ; �\�񂵂ă��^�[��
    reloadFlag := true
    return
  }
  
  ; �\�񂪓����ĂȂ�������A�Ȃɂ��������^�[��
  if(!reloadFlag)
    return true

  reloadFlag := false

  ; ini�t�@�C���̃����[�h
  ; �V�X�e���p�����[�^�̕ύX�����邩������Ȃ��̂ŁA�V�X�e���֘A�̏�������
  ; �����ɍs��
  ; �܂��Areload���́Aini�t�@�C���̋L�q�ɃG���[�������Ă��A�I�������ɁA���̂܂܂�
  ; ����B

  ; �I�������̒�`
  DMS_End("init", false)
  
  ; �V�X�e�����f�t�H���g�l�ݒ�
  DMS_SystemParameters()

  ; ini�t�@�C���̓ǂݍ���
  ini_file := DMS_Default("ini_file")
  if(!DMS_ReadIniFile(ini_file, message))
  {
    DMS_End("end", message)
    return false
  }

  ; ���j���[�̍č쐬
  DMS_Menu()
  return true
}

/*
 ...............................................................................

  �N���b�N�t�b�N�p�n���h��
  DMS_Click()���ĂԂ���
 ...............................................................................
*/
DMS_Click_Sub:
  DMS_Click()
return

/*
 ...............................................................................

  �N���b�N�t�b�N����Ă΂�鏈��
  
  DMS_Click()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      DMS_Main�̋N�����AtimeAfterClick�̎��Ԃ����A��ɐݒ肷��B
 ...............................................................................
*/
DMS_Click()
{
  ; click�ŁA�����Ǔ��͋��L���f�^�b�`����B�������Ȃ��Ɣ��f����Ȃ��L�����b�g
  ; ���W������B
  CAR_GetCaretPos(false,dummy,dummy,"",true)

  time := DMS_SystemParameters("timeAfterClick")
  SetTimer, DMS_Main, %time%
  return
}

/*
 ...............................................................................

  �^�X�N�g���C�A�C�R���̉E�N���b�N���j���[�쐬
  
  DMS_Menu()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      ���j���[�̍쐬�B���j���[���ڂ��I�����ꂽ��A���ׂ�DMS_MenuHandle�ɔ��
 ...............................................................................
*/
DMS_Menu()
{
  ; �\�����镶����̎��o��
  reload := DMS_SystemParameters("menu_reload")
  end    := DMS_SystemParameters("menu_end")
  tip    := DMS_SystemParameters("title")

  ; ���j���[�̍쐬
  Menu, TRAY, DeleteAll
  Menu, TRAY, NoStandard
  Menu, TRAY, Add, %reload%, DMS_MenuHandle
  Menu, TRAY, Add
  Menu, TRAY, Add, %end%, DMS_MenuHandle
  Menu, TRAY, Tip, %tip%
  return
}

/*
 ...............................................................................

  �^�N�X�g���C�A�C�R���̃��j���[���I�����ꂽ�Ƃ��̏���
  
    ����:
      ���j���[���ڂ�1���I�����ꂽ�烊���[�h�A3���I�����ꂽ��A�v�����I������B
 ...............................................................................
*/
DMS_MenuHandle:
  if(A_ThisMenuItemPos == 1)
  {
    DMS_Reload()
  }
  else
  if(A_ThisMenuItemPos == 3)
    ExitApp
return

/*
 ...............................................................................

  ���b�Z�[�W�𑗂�ꂽ�Ƃ��̏���

  DMS_MessageHandle(wParam)
    ����:
      wParam: ������K��
              0 : �����[�h
              1 : �I��
    �߂�l:
      �Ȃ�
    ����:
      ���b�Z�[�W�n���h���̒�`�́A���������ōs���Ă���B
      0x5555�̃��b�Z�[�W���󂯎��ƁA��L�̓�����s���B
 ...............................................................................
*/
DMS_MessageHandle(wParam)
{
  if(wParam == 0)
    DMS_Reload()
  else
  if(wParam == 1)
    ExitApp
}

/*
 ...............................................................................

  �I������
  
  DMS_End(method,param)
    ����:
      method: ������K��
              "init" : ������
              "end"  : �I������
      param:  "init"�̂Ƃ��́A�P�ƃA�v���Ȃ�Atrue,�g�ݍ��݂Ȃ�Afalse
              "end"�̂Ƃ��́A�I�����ɏo�͂��郁�b�Z�[�W
    �߂�l:
      �Ȃ�
    ����:
      "init"�̏ꍇ�́Aparam�̒l���i�[���邾���Ń��^�[��
      "end"�̏ꍇ�́Aparam�̒l�����b�Z�[�W�o�͂��A�P�ƃA�v���Ȃ�A
      �A�v�����I�������A�g�ݍ��݂Ȃ�A�^�C�}�n���h����Off�ɂ�����A���^�[������B
 ...............................................................................
*/
DMS_End(method, param)
{
  static independent
  
  if(method == "init")
  {
    ; ������
    
    independent := param
  }
  else
  if(method == "end")
  {
    ; �I������
    
    
    if(param)
    {
      ; ���b�Z�[�W����������A�����ŏo��
      title := DMS_SystemParameters("title")
      MsgBox, 16,%title%, %param%
    }
    
    ; �^�C�}�n���h���I�t
    SetTimer, DMS_Main, Off
    
    ; �P�Ə풓�A�v���Ȃ�A�A�v�����I������B
    if(independent)
      ExitApp
  }
}

/*
 ...............................................................................

  �V�X�e���p�����[�^�̊Ǘ�
  
  �f�t�H���g�l�ݒ�
  DMS_SystemParameters()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �V�X�e���p�����[�^���A���ׂăf�t�H���g�l�ɐݒ肷��B

  �p�����[�^�ǂݏo��
  DMS_SystemParameters(paramName)
    ����:
      paramName: �V�X�e���p�����[�^�̖��O
    �߂�l:
      paramNmae�̃V�X�e���p�����[�^�̒l
    ����:
      paramNmae�̃V�X�e���p�����[�^�̒l�����o���B
  
  �p�����[�^�ݒ�
  DMS_SystemParameters(paramName, paramVal, true)
    ����:
      paramName: �V�X�e���p�����[�^�̖��O
      paramVal:  �ݒ肵�悤�Ƃ���l
      true:      ���true
    �߂�l:
      �Ȃ�
    ����:
      paramNmae�̃V�X�e���p�����[�^�ɁA�l��ݒ肷��B
  
  �p�����[�^���̃T�|�[�g�m�F
  DMS_SystemParameters(false, paramName)
    ����:
      false:     ���false
      paramName: �m�F����p�����[�^��
    �߂�l:
      paramName�Ŏw�肳�ꂽ�p�����[�^�����A�{�֐����ŊǗ����Ă�����̂Ȃ�true�A
      �����łȂ����false
    ����:
      paramName�Ŏw�肳�ꂽ�p�����[�^�����A�{�֐����ŊǗ����Ă�����̂Ȃ�true�A
      �����łȂ����false��Ԃ��B
      
  �p�����[�^�̐ݒ�l�m�F
  DMS_SystemParameters(false, paramName, paramVal, true)
    ����:
      false:     ���false
      paramName: �m�F����p�����[�^��
      paramName: �m�F����p�����[�^�l
      true:      ���true
    �߂�l:
      paramName�Ŏw�肳�ꂽ�p�����[�^�����AparamVal�Ŏw�肳�ꂽ�l���ݒ�ł���
      �Ȃ�NULL�A�����łȂ���΁A�ݒ�ł��Ȃ��|������������B
    ����:
      paramName�Ŏw�肳�ꂽ�p�����[�^�����AparamVal�Ŏw�肳�ꂽ�l���ݒ�ł���
      �Ȃ�NULL�A�����łȂ���΁A�ݒ�ł��Ȃ��|�������������Ԃ��B
 ...............................................................................
*/
DMS_SystemParameters(val = false, param1=false, param2=false, param3=false)
{
  static time
  static timeAfterClick
  static menu_reload
  static menu_end
  static title
  static gen_max
  static alwaysCaretOn
  static tooltip_num
  static apiwin_num
  
  if(val)
  {
    ; ��P����(�p�����[�^��)���w�肳��Ă���

    if(param2)
    {
      ; ��R������true�Ȃ̂ŁA��Q�����́A�ݒ肵�悤�Ƃ���l
      %val% := param1
      return
    }
    ; ��R������false(�w�肳��ĂȂ�)�̂ŁA�l�̓ǂݏo��
    content := %val%
    return content
  }
  else
  if(param1)
  {
    ; ��Q������true
  
    if(param3)
    {
      ; ��S������true
      ; �ݒ�ł���l���ǂ����`�F�b�N
    
      if((param1 == "time" || param1 == "timeAfterClick") && param2 < 0)
        return "�V�X�e���p�����[�^[" . param1 . "]�́A[" . param2 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0�ȏ�ł��B"
      else
        return ""
    }

    ; ��Q�����Ŏw�肳�ꂽ�p�����[�^���T�|�[�g���Ă��邩�`�F�b�N
    check := ";time;timeAfterClick;menu_reload;menu_end;title;gen_max;alwaysCaretOn;tooltip_num;"
    IfInString, check, `;%param1%`;
      return true
    else
      return false
  }
  else
  {
    ; ��P�A��Q�����Ƃ�false
    ; �f�t�H���g�l�̐ݒ�
    ; �f�t�H���g�l�Ǘ����ɁA�f�t�H���g�l���ݒ肳��Ă��邩�����ˁA�ݒ肳���
    ; �Ȃ�������A�����Ńf�t�H���g�l��ݒ�
  
    time            := DMS_Default("time")
    if(!time)
      time := 500

    timeAfterClick := DMS_Default("timeAfterClick")
    if(!timeAfterClick)
      timeAfterClick := 300

    menu_reload := DMS_Default("menu_reload")
    if(menu_reload == "")
      menu_reload := "ini�t�@�C���ēǂݍ���(&R)"

    menu_end := DMS_Default("menu_end")
    if(menu_end == "")
      menu_end := "�I��(&X)"

    title := DMS_Default("title")
    if(title == "")
      title := "�Ȃ܂�IME"

    gen_max := DMS_Default("gen_max")
    if(gen_max == "")
      gen_max := 64

    alwaysCaretOn := DMS_Default("alwaysCaretOn")
    if(alwaysCaretOn == "")
      alwaysCaretOn := ""

    tooltip_num := DMS_Default("tooltip_num")
    if(tooltip_num == "")
      tooltip_num := 19

    apiwin_num := DMS_Default("apiwin_num")
    if(apiwin_num == "")
      apiwin_num := 18

    return
  }
}

/*
----------------------------------------------------------------------------
 4.ini�t�@�C���ǂݏo����

   �ݒ��`�p��ini�t�@�C������p�����[�^��ǂݏo���B

----------------------------------------------------------------------------
*/

/*
 ...............................................................................

  ini�t�@�C����ǂݏo��
  
  DMS_ReadIniFile(ini_file, ByRef message)
    ����:
      ini_file:   ini�t�@�C���̃t�@�C����
      message:    ini�t�@�C���ɃG���[���������Ƃ��A�G���[���R�̃��b�Z�[�W������
    �߂�l:
      true�Ȃ�Aini�t�@�C���̓ǂݍ��ݐ���I���Bfalse�Ȃ�Aini�t�@�C���ɃG���[
      ������A����I���ł͂Ȃ��B
    ����:
      ��U�A���ׂ�ini�t�@�C������ǂݏo������ɁA�V�X�e���p�����[�^�̃`�F�b�N��
      �l�̐ݒ�B
      ���̌�AParamBlock()���R�[�����A�p�����[�^�Z�N�V�����̏���������B
 ...............................................................................
*/
DMS_ReadIniFile(ini_file, ByRef message)
{
  ; �Ƃ肠�����A�t�@�C������ini����ǂݏo��
  if(!INI_ReadIniFile(ini_file, raw_ini, message,true,false))
    return false
    
  ; �܂��Asystem�p�����[�^�����o��
  parse_ini := raw_ini
  Loop
  {
    ; 1�G���g�����ƂɁA�l�����o���B
    if(!INI_ParseIni(parse_ini, section, entryName, entryVal))
      break

    if(entryName == "")
      continue
      
    if(section == "system")
    {
      ; �V�X�e���Z�N�V�����������B
      
      ; �V�X�e���p�����[�^�Ƃ��āA�T�|�[�g���Ă���p�����[�^�����H
      if(!DMS_SystemParameters(false, entryName))
      {
        message := "�V�X�e���p�����[�^�ŁA[" . entryName . "]�Ƃ����p�����[�^�̓T�|�[�g���Ă܂���B"
        return false
      }
      
      ; �V�X�e���p�����[�^�Ƃ��āA�ݒ�\�Ȓl���H
      message := DMS_SystemParameters(false, entryName, entryVal, true)
      if(message)
        return false
        
      ; �V�X�e���p�����[�^�ݒ�
      DMS_SystemParameters(entryName, entryVal, true)
    }
  }
  
  ; ���ɁA�p�����[�^�Z�N�V����(�p�����[�^�u���b�N)�̏���
  message := DMS_ParamBlock(raw_ini)
  if(message)
    return false
    
  return true
}

/*
----------------------------------------------------------------------------
 5.�����Ǘ���

   ini�t�@�C������͂��Đe�q�֌W����ǂݏo���A�Ǘ�����B
   IME��ԓ��ɉ����ď����𖞂����Z�N�V���������肵�A�p�����[�^�ݒ������B

----------------------------------------------------------------------------
*/

/*
 ...............................................................................

  �p�����[�^�u���b�N(�p�����[�^�Z�N�V������������������ɂ܂Ƃ߂�����)��
  �쐬�ƊǗ�
  
  �p�����[�^�u���b�N���o��
  DMS_ParamBlock()
    ����:
      �Ȃ�
    �߂�l:
      �p�����[�^�u���b�N�S��
    ����:
      �p�����[�^�u���b�N�S�̂�Ԃ��B�ȉ��̃t�H�[�}�b�g�����B
      
      paramBlocks := blocks `b1b blocks `b1b blocks
       (`b��b(blother)�ň͂܂ꂽ����ԍ��ɂ���āA��������̃u���b�N��
        ���������)
        
      blocks := �eblock `b1c �qblocks
       ( `b��c(child)�ň͂܂ꂽ����ԍ��ɂ���āA�e�Ǝq�����������)

      block  := ������1`a����1`v������2`a����2`n�\����1`a�\��1`v�\����2`a�\��2
       (`n�ɂ���āA�������ƕ\�������������B
        �������ƕ\�����Ƃ��A�X�̃p�����[�^��`v�ŕ��������B
        �܂��A�p�����[�^�̖��O�ƒl��`a�ŕ��������)

  �p�����[�^�u���b�N�쐬(��ԍŏ�)
  DMS_ParamBlock(raw_ini)
    ����:
      raw_ini:  ini�t�@�C������̕�����ɂ܂Ƃ߂����́B
                INI_ReadIniFile����̏o��
    �߂�l:
      raw_ini�ɃG���[���������ꍇ�́A�G���[���R��\��������
      �G���[���Ȃ����NULL
    ����:
      raw_ini�̃p�����[�^�Z�N�V��������͂��A�]�������₷���`�ɂ܂Ƃ߂�
      �p�����[�^�u���b�N���쐬���A�����ɕێ�����BDMS_ParamBlock()�Ŏ��o����B
  
  �p�����[�^�u���b�N�쐬(�ċN�Ăяo���ŃR�[�����ꂽ�Ƃ�)
  DMS_ParamBlock(false, parent, genCon, notErase, familyList)
    ����:
      false:     ���false
      parent:    ���̍ċN�Ăяo���̑ΏۂƂȂ�e�Z�N�V������
                 ���̃Z�N�V��������e�Ƃ���Z�N�V�����̏������s��
      genCon:    ����ԍ��B�e��NULL(parent�p�����[�^���Ȃ�)�̃Z�N�V������0�B
                 ���̎q��1�A����2...
      notErase:  ���������Z�N�V�����́A������raw_ini(parse_ini)����폜���邪�A
                 notErase��true�̏ꍇ�́A�폜���Ȃ��B
                 �e���l�ȏ㎝�q�̑�(�Б��A�₵�Ⴒ...)�̏����̏ꍇ�AnotErase
                 ��true�ɂ���B
      familyList:�ƌv�}�B��c��X�̃Z�N�V��������'v�ŋ�؂��đ�����B

    �߂�l:
      raw_ini�ɃG���[���������ꍇ�́A�G���[���R��\��������
      �G���[���Ȃ����NULL
    ����:
      ������parse_ini(�ŏ���raw_ini)�̃p�����[�^�Z�N�V��������͂��A
      �]�������₷���`�ɂ܂Ƃ߂��p�����[�^�u���b�N���쐬���A�����ɕێ�����


 �p�����[�^�u���b�N�쐬�̓����������

 �{�֐��́A���L�̂S�̋@�\������
 1)�w�肳�ꂽ�e������(parent�p�����[�^�Ŏw�肳�ꂽ�e���A�����ŗ^����ꂽ�e��
   ����)�q��������B
 2)�������q�̏����p�����[�^�ƕ\���p�����[�^�����o���AparamBlocks�ɋL�^����B
   paramBlocks�ɂ́A�e���q�����̏��Ԃŕ��Ԃ悤�ɂ���B
 3)�q�p�����[�^�̎q(��)��T�����߁A�ċN�Ăяo������
 4)�����ς̎q�Z�N�V�������폜����B

 4)�̏����ςƂ́A���L�̓�̏����𖞂������̂ł���B
   A)�e���A�����̐e(�����������)�������Ă��Ȃ���notErase��false
   B)�e�͍���w�肳�ꂽ�e��l����
 �����łȂ���΁A�����ςƂ͂Ȃ炸�A3)�ő���T���ɂ����Ƃ����AnotErase��true��
 ���čċN�Ăяo������K�v������B

 �܂��A1)��4)���s���B
 �ÓI�ϐ�"parse_ini"���p�[�X���āA�w�肵���e�����q��
 ��������B���̍ۂɁA���̎q�̖��O�ƁA���̎q�����p�����[�^�ƁA���̎q�������ς�
 �ǂ������L�^���郊�X�g������B
 �܂��A���̎q�������ςɂȂ�̂Ȃ�Aparse_ini����A���̎q�̃Z�N�V��������������B
 �ƁA�����Ă��A�s���|�C���g�ŏ�������̂͑�ςȂ̂ŁAparse_ini���p�[�X
 ���Ă����ۂɁA�����ςłȂ��Z�N�V������ۑ����Ă���(remain_ini)�A������Ō��
 parse_ini�Ƃ��邱�ƂŁA�����������Ƃɂ���B
 �܂��A�e�q�������[�v������邽�߂ɁA�ƌn���X�g�𑗂�A�������ꂽ�q���e��
 �Ȃ��������ǂ����`�F�b�N����B
 
 ���ɁA2)��3)���s���B
 �q�̖��O�ƃp�����[�^�̃��X�g���p�[�X����B
 �p�����[�^��paramBlocks�ɋL�^���A����ɁA�q�̖��O�̐e�����q(��)��T���ɁA
 �ċN�Ăяo������B�ċN�Ăяo���̂Ƃ��ɁA�����ς������łȂ����ŁAnotErase��
 �ύX����B����ɁA�ƌn���X�g�Ɏq�̖��O��ǉ����āA�ċN�Ăяo������B
 �������������΁AparamBlocks�ɂ͑��̃p�����[�^���ǉ������B�܂��A�����ς�
 �Ȃ�΁Aparse_ini�͂��̕��Z���Ȃ�B

 �����A��ԏ�̌Ăяo��(�w�肵���e���k��)�������ꍇ�́Aparse_ini�ɍŌ��
 �c�����Z�N�V�����́A�Ō�܂ŏ����ł��Ȃ������A�܂�A�e�����݂��Ȃ������A
 �G���[�Z�N�V�����Ƃ������ƂɂȂ�B
 
 �������I������Z�N�V�������Aparse_ini����ǂ�ǂ񌸂炵�Ă������ƂŁA
 �ċN�Ăяo�����ăp�[�X���Ȃ���΂Ȃ�Ȃ��Z�N�V�����̐��������Ă����̂ŁA
 �S�̂̏������x����ɂȂ���B�܂��A�����ł��Ȃ������Z�N�V��������Ń`�F�b�N
 ���邱�ƂŁA�e�����݂��Ȃ��Z�N�V�����̃`�F�b�N���A���ʂȃp�[�X�����邱�ƂȂ��A
 ���o�ł���B����܂��A�������x����Ɍq����B
 
 �����̃o�[�W�����́A�����ƒP���ȃA���S���Y���ł���Ă������A�ċN�Ăяo����
 ���p�[�X���K��I�ɑ����Ă��܂��A�V�����ɂȂ�Ȃ��قǏd�������̂ŁA��L��
 �悤�ɏ����������B��₱��������ǁA���炦�Ă��������B

 ...............................................................................
*/
DMS_ParamBlock(raw_ini = false, parent = "", genCon = 0, notErase = false, familyList = "")
{
  static paramBlocks
  static parse_ini

  ; DMS_ParamBlock()�ŃR�[������Ă���Ȃ�A�p�����[�^�u���b�N��Ԃ�
  if(!raw_ini && !parent)
    return paramBlocks

  ; �e��NULL�A�܂�A��ԍŏ��̃R�[���Ȃ̂ŁAparamBlock��������
  if(!parent)
    paramBlocks := ""
  
  ; raw_ini��NULL�ł͂Ȃ��̂ŁA������parse_ini��raw_ini�ɕۑ�
  if(raw_ini)
    parse_ini := raw_ini

  ; �ƌv�}��NULL�Ȃ�A�ŏ���'v������Ă����B
  ; ��L�݂̂���if�́A���ׂē����^�C�~���O�����A�O�̂��߂ɕ����Ă���
  if(familyList == "")
    familyList := "`v"

  ; AutoHotkey�̍ċN�Ăяo���ɐ��������邩������Ȃ��̂ŁA
  ; ���オ�[���Ȃ肷���Ȃ�Ȃ��悤�ɐ�������B
  if(genCon > DMS_SystemParameters("gen_max"))
    return "�ݒ�ł��鐢�㐔��" . DMS_SystemParameters("gen_max") . "����܂łł��B[" . parent . "]"

  parent_num  := 0
  found := false
  section_in := false
  this_ini := ""
  remain_ini := ""
  childList := ""
  Loop
  {
    ; ini�t�@�C������A1�G���g�����o��
    if(!INI_ParseIni(parse_ini, section, entryName, entryVal))
      break
      
    ; �V�X�e���Z�N�V�����ł͂Ȃ����H
    if(section != "system")
    {
      ; ���̃Z�N�V�����ɂȂ��ď��߂ẴG���g����������A�ۑ��pini(this_ini)��
      ; �Z�N�V��������ۑ�
      if(!section_in)
        INI_AddIni(this_ini, section, "")
        
      section_in := true

      ; �G���g���������邩(�Ȃ�������A���̃Z�N�V�����̍Ō�)
      if(entryName)
      {
        ; �e�p�����[�^���H
        if(entryName == "parent")
        {
          ; �e�̌��J�E���g�A�b�v
          parent_num++

          if(section == entryVal)
            return "�������g��e�ɂ��邱�Ƃ͂ł��܂���B[" . section . "]"

          if(parent == entryVal)
          {
            ; �w�肳�ꂽ�e�����q��������
            found := true
            ; notErase�łȂ���΁A�e�p�����[�^����������
            if(notErase)
              INI_AddIni(this_ini, "", entryName, entryVal)
          }
          else
            INI_AddIni(this_ini, "", entryName, entryVal)
        }
        else
        {
          ; �e�p�����[�^�ȊO
          ; �Ƃ肠�����Athis_ini�ɓ���Ă���
          INI_AddIni(this_ini, "", entryName, entryVal)
        }
      }
      else
      {
        ; �{�Z�N�V�����̏I���
        section_in := false
        
        ; ���̃p�����[�^�u���b�N�́A�w��̐e�����q�u���b�N��������
        if(found || (parent_num == 0 && parent == ""))
        {
          ; �܂��A���̎q���A���ɐe���������Ƃ͂Ȃ���(�e�q�������[�v)���`�F�b�N
          IfInString, familyList, `v%section%`v
            return "�e�q�������[�v�ł��B[" . parent . "," . section . "]"

          ; ���̎q�u���b�N�́A"������"���ǂ���
          ; "������"�Ƃ́AnotErase���^�łȂ��A�e�͈�l����(���邢��0)�̏ꍇ�̂�
          if(!notErase && parent_num <= 1)
            notProcessed := false
          else
            notProcessed := true
            
          ; remain_ini��������
          ; ���̃Z�N�V�����������ς݂Ȃ�Aremain_ini�ɉ����Ȃ�
          if(notProcessed)
            remain_ini := remain_ini . this_ini . "`n"

          condpar := ""
          disppar := ""
          ; ���̃Z�N�V�����̃p�����[�^�����o��
          Loop
          {
            if(!INI_ParseIni(this_ini, section, entryName, entryVal))
              break
      
            if(entryName == "")
              break ; �{���͂��ׂĂ����Ŕ����Ă��܂��B�������L��if�͈Ӗ����Ȃ�

            if(entryName == "parent")
              Continue
    
            ; �����p�����[�^���H
            if(DMS_CondParameters(false, false, entryName))
            {
              ; NULL������͎w��ł��Ȃ�
              if(entryVal == "")
                return "�����p�����[�^�ł́ANULL������͎w��ł��܂���B[" . section . "," . entryName . "]"

              ; �p�����[�^�̒l�̃`�F�b�N
              message := DMS_CondParameters(false, false, entryName, entryVal)
              if(message)
                return message
            
              ; �p�����[�^�̒l�̕ϊ�
              entryVal := DMS_CondParameters(false, false, entryName, entryVal,2)

              ; �����p�����[�^�̕ۑ�
              condpar := condpar . entryName . "`a" . entryVal .  "`v"
            }
            else ; �\���p�����[�^���H
            if(DMS_DispParameters(false, false, entryName))
            {
              ; �p�����[�^�̒l�̃`�F�b�N
              message := DMS_DispParameters(false,false, entryName, entryVal,1)
              if(message)
                return message

              ; �p�����[�^�̒l�̕ϊ�
              entryVal := DMS_DispParameters(false, false, entryName, entryVal,2) 

              ; �\���p�����[�^�̕ۑ�
              disppar := disppar . entryName . "`a" . entryVal .  "`v"
            }
            else ; �s���ȃp�����[�^
              return "�s���ȃp�����[�^�ł��B[" . section . "," . entryName . "]"
          }
          ; �q���X�g�쐬
          ; �q���X�g = �q `b �q `b �q `b...
          ; �q       = ���O `f �p�����[�^ `f �����σt���O
          childList := childList . section . "`f" . condpar . "`n" . disppar . "`f" . notProcessed . "`b"

        }
        else
        {
          ; �w�肵���e�����Z�N�V�����ł͂Ȃ������B�܂�A�������Z�N�V������
          ; ����Bremain_ini�ɉ�����
          remain_ini := remain_ini . this_ini . "`n"
        }
        
        ; �{�Z�N�V�����̏����N���A����
        parent_num := 0
        found := false
        this_ini := ""
      }
    }
  }
  
  ; �����ς݃u���b�N�������������X�g���Aparse_ini�ɐݒ肷��
  parse_ini := remain_ini

  ; childList���p�[�X���āA�p�����[�^�̐ݒ�ƁA���T��������
  Loop, parse, childList , `b
  {
    if(!A_LoopField)
      Continue
      
    ; �q�̖��O�ƁA�p�����[�^�ƁA�����σt���O�𕪗�
    StringSplit, ch, A_LoopField , `f
    child := ch1
    param := ch2
    notProcessed := ch3

    ; �p�����[�^�̐ݒ�
    paramBlocks := paramBlocks . param . "`b" . genCon . "c"

    ; ���T��(�ċA�Ăяo��)
    message := DMS_ParamBlock("", child, genCon + 1, notProcessed, familyList . child . "`v")
    if(message)
      return message
   
    ; ���̒ǉ��̂��߂�
    paramBlocks := paramBlocks . "`b" . genCon . "b"
  }

  if(parent == "")
  {
    ; parent���k���Ƃ������Ƃ́A��ԓ��̃R�[���ł���B���̎��_�ŁA
    ; parse_ini���k������Ȃ��Ƃ������Ƃ́A�e�w�肪��������Ă��Ȃ�
    ; �Z�N�V����������Ƃ������ƁB�G���[�Ń��^�[������B
    ; ���͐e�����݂��Ă��A�e�̐e�w�肪���s���Ă��āA�Ō�܂Ŏc���Ă���
    ; ���Ƃ��l������B�����ŁA�{���ɑ��݂��Ȃ��e�w����`�F�b�N����B
    check_ini := parse_ini
    Loop
    {
      if(!INI_ParseIni(check_ini, section, entryName, entryVal))
        break
      
      if(entryName == "parent")
      {
        check2_ini := parse_ini
        found := false
        Loop
        {
          if(!INI_ParseIni(check2_ini, tmp_sec, tmp_nme, tmp_val))
            break
            
          if(tmp_nme == "" && entryVal == tmp_sec)
          {
            found := true
            break
          }
        }
        
        if(!found)
          return "���݂��Ȃ��e�Z�N�V�������w�肳��Ă��܂��B[" . section . "," . entryVal . "]"
      }
    }
  }
  
  return ""
}

/*
 ...............................................................................

  IME���̏�Ԃ𒲂ׂāA�p�����[�^�Z�N�V������I�����A�\���p�����[�^��ݒ肷��
  
  DMS_SelectParameters(actwin, car_x, car_y)
    ����:
      actwin:   ���݃A�N�e�B�u�ȃE�C���h�E��ID
      car_x:    �L�����b�g��x���W(�X�N���[�����W�n)
      car_y:    �L�����b�g��y���W(�X�N���[�����W�n)
    �߂�l:
      true�Ȃ�A�����Ƀ}�b�`�����p�����[�^�Z�N�V�������������B
      false�Ȃ�A��������Ƀ}�b�`�����p�����[�^�Z�N�V�������Ȃ������B
    ����:
      �悤�����DMS_SelectParamBlock���R�[������B
 ...............................................................................
*/
DMS_SelectParameters(actwin, car_x, car_y)
{
  ; �p�����[�^�u���b�N�̃��X�g���擾
  paramBlocks := DMS_ParamBlock()
  
  ; �����p�����[�^�I��������
  DMS_InitCondParameters(actwin, car_x, car_y)

  ; �\���p�����[�^������
  DMS_InitDispParameters(actwin, car_x, car_y)
  
  ; �p�����[�^�I��
  return DMS_SelectParamBlock(paramBlocks, 0)
}


/*
 ...............................................................................

  �����𖞂����p�����[�^�Z�N�V����(���܂Ƃ߂��p�����[�^�u���b�N)��I�����A
  ���̒��̕\���p�����[�^���ADMS_DispParameters()�ɐݒ肷��B
  
  DMS_SelectParamBlock(paramBlocks, genCon)
    ����:
      paramBlocks:  �p�����[�^�u���b�N�B���L�̃t�H�[�}�b�g������

      paramBlocks := blocks `b1b blocks `b1b blocks
       (`b��b(blother)�ň͂܂ꂽ����ԍ��ɂ���āA��������̃u���b�N��
        ���������)
        
      blocks := �eblock `b1c �qblocks
       ( `b��c(child)�ň͂܂ꂽ����ԍ��ɂ���āA�e�Ǝq�����������)

      block  := ������1`a����1`v������2`a����2`n�\����1`a�\��1`v�\����2`a�\��2
       (`n�ɂ���āA�������ƕ\�������������B
        �������ƕ\�����Ƃ��A�X�̃p�����[�^��`v�ŕ��������B
        �܂��A�p�����[�^�̖��O�ƒl��`a�ŕ��������)
        
      genCon:       ����ԍ��B

    �߂�l:
      true�Ȃ�A�����Ƀ}�b�`�����p�����[�^�Z�N�V�������������B
      false�Ȃ�A��������Ƀ}�b�`�����p�����[�^�Z�N�V�������Ȃ������B
    ����:
      �܂��A�Z��𕪊����āA�Z�����ցA�������`�F�b�N�B
      ���ׂĖ��������̂���������A���̒��̕\���p�����[�^��DMS_DispParameters()
      �ɐݒ�B���̂��ƁA���̌Z��̎q�����o���A����ԍ���+1���āA�ċN�Ăяo��
 ...............................................................................
*/
DMS_SelectParamBlock(paramBlocks, genCon)
{
  ; ���̐���̐���ԍ��̌Z��𕪊�
  ; ['b����ԍ�b]���A��U'f�Œu��������
  StringReplace, brotherBlocks, paramBlocks, `b%genCon%b, `f, All

  ; �Z��̐������̃��[�v
  ; �����𖞂����u���b�N������������A�{�֐����甲����
  Loop, parse, brotherBlocks, `f
  {
    if(!A_LoopField)
      Continue
      
    ; �eblock�Ǝqblocks�𕪊�
    StringReplace, parChiBlocks, A_LoopField, `b%genCon%c, `f, All
    StringSplit, parChi, parChiBlocks , `f
    parentBlock := parChi1
    childBlocks := parchi2

    ; �eblock�̏������ƕ\�����𕪊�
    StringSplit, condDisp, parentBlock , `n
    condPars := condDisp1
    dispPars := condDisp2

    ; �����̐��̃��[�v
    ; �����𖞂�����������A���[�v���甲����
    not_meet := false
    Loop, parse, condPars, `v
    {
      if(!A_LoopField)
        Continue

      ; �������Ə����l�𕪊�
      StringSplit, nameVal, A_LoopField , `a

      ; �������[�`���Ăяo��
      if(!DMS_CondParameters(nameVal1,nameVal2))
      {
        not_meet := true
        ; break ���u���b�N�̑S�����͈ꉞ�]�����邱�Ƃ�
      }
    }
    
    if(!not_meet)
    {
      ; �S�����ɍ����u���b�N����������
      ; �\���p�����[�^�̐ݒ�
      Loop, parse, dispPars, `v
      {
        if(!A_LoopField)
          Continue

        ; �\�����ƕ\���l�𕪊�
        StringSplit, nameVal, A_LoopField , `a

        ; �ݒ�֐��Ăяo��
        DMS_DispParameters(nameVal1,nameVal2,true)
      }
      
      ; �q�u���b�N�̌���
      ; �{�֐����ċN�Ăяo������
      genCon++
      DMS_SelectParamBlock(childBlocks, genCon)
      return true
    }
  }

  ; ���̐���̌Z��ł́A�ЂƂ������ɂ����u���b�N���Ȃ�����
  return false
}


/*
 ...............................................................................

  �����p�����[�^�̏�����
  �{�A�v����0.3�b�Ƃ��̃^�C�}�N�����Ɉ�x�R�[�������B
  ���̂��ƁAini�t�@�C���̏����p�����[�^�̐ݒ�ɏ]���A���x��IME��ԓ��̃`�F�b�N
  ������̂ŁA���̃^�C�~���O�Ō��݂̏�Ԃ��擾���Ă����Ƃ悢�B
  
  DMS_InitCondParameters(actwin, car_x, car_y)
    ����:
      actwin:   ���݃A�N�e�B�u�ȃE�C���h�E��ID
      car_x:    �L�����b�g��x���W(�X�N���[�����W�n)
      car_y:    �L�����b�g��y���W(�X�N���[�����W�n)
    �߂�l:
      �Ȃ�
    ����:
      DMS_CondParameters(false, actwin, car_x, car_y)���R�[�����邾��

 ...............................................................................
*/
DMS_InitCondParameters(actwin, car_x, car_y)
{
  DMS_CondParameters(false, actwin, car_x, car_y)
}

/*
 ...............................................................................

  �����p�����[�^�̕ێ��ƁA�����̕]��

  ������Ԃ̊��S�N���A
  DMS_CondParameters()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �{�A�v���N�����Ɉ�x�����R�[�������B
      ������Ԃ����ׂăN���A����B

  ������Ԃ�������(IME����Ԏ擾)
  DMS_CondParameters(false, actwin, dsp_x, dsp_y)
    ����:
      false:    ���false
      actwin:   ���݃A�N�e�B�u�ȃE�C���h�E��ID
      car_x:    �L�����b�g��x���W(�X�N���[�����W�n)
      car_y:    �L�����b�g��y���W(�X�N���[�����W�n)
    �߂�l:
      �Ȃ�
    ����:
      �{�A�v����0.3�b�Ƃ��̃^�C�}�N�����Ɉ�x�R�[�������B
      ���L�́u�����̃T�|�[�g�m�F�v�̍ۂɖ₢���킳�ꂽcondName��ۑ�����
      initCondList�ɏ]���A�e�p�����[�^�̏��������s���B
      ���̂��ƁAini�t�@�C���̏����p�����[�^�̐ݒ�ɏ]���A
      ���x��IME��ԓ��̃`�F�b�N������̂ŁA���̃^�C�~���O�Ō��݂̏�Ԃ�
      �擾���Ă����Ƃ悢(��������Ȃ�) �B

  �����]��
  DMS_CondParameters(condName, val)
    ����:
      condName: �����p�����[�^��
      val:      �����l�B
    �߂�l:
      ���݂�IME���̏�Ԃ��AcondName�̏����p�����[�^=val�ł�������Atrue
      �����łȂ���΁Afalse
    ����:
      ��L�́u������Ԃ��������v���Ă΂ꂽ���ƁAini�t�@�C���̐ݒ�ɏ]���A
      ���x�����́u�����]���v���Ă΂��B
      ���ۂɂ́A�X�̏����p�����[�^�ɑΉ�����A���L�́u�����p�����[�^�p�b�N�v��
      �Ă�

  �������̃T�|�[�g�m�F
  DMS_CondParameters(false, false, condName)
    ����:
      false:    ���false
      false:    ���false
      condName: �����p�����[�^��
    �߂�l:
      condName���T�|�[�g���Ă�������p�����[�^���ł�������true�A
      �����łȂ���΁Afalse
    ����:
      ���L�́u�����p�����[�^�p�b�N�v�ɁAcondName�̒�`�����邩�ǂ������ׂ�
      (���x�������邩�ǂ���isLabel�Œ��ׂ�)�A�����true�A�Ȃ����false��Ԃ��B
      ���̍ہA�T�|�[�g�m�F�ɗ���condName���A������initCondList�ɕۑ����Ă����B

  �����̕]���l�m�F
  DMS_CondParameters(false, false, paramName, paramVal)
    ����:
      false:     ���false
      false:     ���false
      paramName: �����p�����[�^��
      paramVal:  �ݒ肵�悤�Ƃ���l
    �߂�l:
      condName�Ƃ������O�̏����p�����[�^���AparamVal�Ƃ����l��ݒ�ł����
      NULL,�����łȂ���΁A�ݒ�ł��Ȃ��|������������
    ����:
      paramName�́u�����p�����[�^�p�b�N�v�ɁAparamVal���Ή��\������

  �����̕]���l�̕ϊ�
  DMS_CondParameters(false, false, paramName, paramVal, 2)
    ����:
      false:     ���false
      false:     ���false
      paramName: �����p�����[�^��
      paramVal:  �ݒ肵�悤�Ƃ���l
      2:         ���2
    �߂�l:
      paramVal�̒l������Ŏg�p����l�ɕϊ����A���̒l��Ԃ��B
      �u�����]���v���R�[������Ƃ��́A���̒l�ŃR�[�����Ȃ���΂Ȃ�Ȃ��B
    ����:
      ��L�̒ʂ�

 ...............................................................................
*/
DMS_CondParameters(val = false, param1 = false, param2 = "", param3 = "",param4 = false)
{
  global DMS_CondParam1,DMS_CondParam2,DMS_CondParam3,DMS_CondResult
  static initCondList

  if(val)
  {
    ; �����]�����s��
    ; �Ή�����u�����p�����[�^�p�b�N�v���R�[��
    vector = DMS_Cond_%val%
    DMS_CondParam1 := param1
    GoSub, %vector%
    return DMS_CondResult
  }
  else
  if(param1)
  {
    ; ������ԏ�����
    ; initCondList�ɕۑ����ꂽ�����p�����[�^����ÂR�[������
    DMS_CondParam1 := param1
    DMS_CondParam2 := param2
    DMS_CondParam3 := param3
    
    Loop, parse, initCondList, `,
    {
      if(!A_LoopField)
        break
      GoSub, %A_LoopField%
    }
      
    return
  }
  else
  if(param2 != "")
  {
    if(param3 != "")
    {
      ; �����]���l�m�F(���ƁA�����g�p�̒l�ւ̕ϊ���
      vector = DMS_Cond_%param2%_check
      DMS_CondParam1 := param3
      DMS_CondParam2 := param4
      GoSub, %vector%
      return DMS_CondResult
    }
    else
    {
      ; �������m�F(�������p�x�N�^�e�[�u���쐬)
      vector = DMS_Cond_%param2%_init
      if(IsLabel(vector))
      {
        IfNotInString, initCondList, %vector%
          initCondList := initCondList . vector . "`,"
        return true
      }
      else
        return false
    }
  }
  else
    initCondList := ""
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N
  
  �X�̏����p�����[�^�́A���L�ɐ�������A���ʂ���C���^�t�F�[�X��K��
  �����Ȃ���΂Ȃ�Ȃ��B
  �t�Ɍ����ƁA���̃C���^�t�F�[�X�������ƂŁA���̃R�[�h�͈�ؕύX���邱�ƂȂ��A
  �����p�����[�^�����R�ɑ��₷���Ƃ��ł���B
  �܂�Aini�t�@�C���ɏ����ꂽ�����p�����[�^�́A���̖��O�����̂܂܎g����
  ���L�̃��x�����R�[�����邱�ƂŁAif����p�����ɁA�p�����[�^�ɉ������]����
  �s���悤�ɂȂ��Ă���B������A���L�Œ�`����C���^�t�F�[�X�����T�u���[�`��
  �������邾���ŁA�����p�����[�^�ǉ����ł���悤�ɂȂ��Ă���B
  
  �����L�́uxxxx�v�́A�X�̏����p�����[�^��������B�uIMEopen�v�Ƃ��B
  �����L�͂��ׂāA�T�u���[�`�����x���ł���B�֐��ł͂Ȃ��̂Œ���

  �����]��
  DMS_Cond_xxxx
    ����:  
      DMS_CondParam1(�O���[�o���ϐ�)
        �]���������l
    �߂�l:
      DMS_CondResult(�O���[�o���ϐ�)
        ���݂̏�Ԃ��A�����ŗ^�����l�𖞂������̂ł���΁Atrue�A�����łȂ����
        false��Ԃ�
    ����:
      xxxx�̏����p�����[�^�̏�Ԃ𒲂ׁA�����œn���ꂽ�l�ł�������Atrue��Ԃ��B
      �Ⴆ�΁Axxxx��IMEopen�ł�������AIME�̏�Ԃ𒲂ׁA1�ł������Ƃ��A
      DMS_CondParam1��1�ł�������ADMS_CondResult��true���i�[���A���^�[������B

  ������
  DMS_Cond_xxxx_init
    ����:  
      DMS_CondParam1(�O���[�o���ϐ�)
        �A�N�e�B�u�ȃE�C���h�E��ID
      DMS_CondParam2(�O���[�o���ϐ�)
        �L�����b�gx���W
      DMS_CondParam3(�O���[�o���ϐ�)
        �L�����b�gy���W
    �߂�l:
      �Ȃ�
    ����:
      �Ⴆ��0.3�b�Ɉ��{�A�v���̃^�C�}�n���h�����N�������Ƃ��A
      ��L�́u�����]���v�ɐ旧���A��񂾂��A���́u�������v���R�[�������B
      ��L�́u�����]���v�́Aini�t�@�C���̋L�q�ɏ]���A���x�ł��R�[�������
      �\��������B�������A���́u�������v�́A�K����񂵂��R�[������Ȃ��B
      ���������āA�u�����]���v�ɐ旧���A���́u�������v�̃^�C�~���O��IME��ԓ���
      �擾���Ă����A���������ϐ��ɕۑ����Ă����āA�u�����]���v�̂Ƃ��́A�����
      �����Ƃ��r���邾���A�Ƃ��������ɂ���΁AIME��ԓ��𒲂ׂ镉�ׂ�����A
      �S�̂��y���ł���\��������B
      �������A��L�̎����̃f�����b�g�Ƃ��ẮA���́u�������v�́A
      ini�t�@�C���̂ǂ�����xxxx�̏����p�����[�^���L�q����Ă�����A
      �K�����̓R�[������Ă��܂����Ƃł���Bini�t�@�C���̕]���̗��ꂩ�炷��ƁA
      xxxx�Ɋւ���u�����]���v�́A�����R�[������Ȃ��\��������B���̂悤��
      �ꍇ�A��L�̎����ł́A�����]�����Ȃ��̂ɁAIME��ԓ��̎擾�͕K�������
      ���܂��A�������ĕ��ׂ��d���Ȃ�Ƃ����\��������B
      ���̖�������邽�߂ɂ́A���́u�������v�ł́A�u�������v���Ă΂ꂽ�Ƃ���
      �L�^�������Ă����A�u�������v��̏��߂Ắu�����]���v�ŁA��񂾂��A
      IME��ԓ��̎擾���s���A�Ƃ����������l������B����Ȃ�A
      IME��ԓ��̎擾�͏�ɍŏ��ł��ށB�������Aif���������Ă�₱�����Ȃ�Ƃ���
      �f�����b�g������B
      �ꉞ�A�{�A�v���ł́A��L�̍l���Ŏ������Ă���B

  �����̕]���l�m�F
  DMS_Cond_xxxx_check
    ����:  
      DMS_CondParam1(�O���[�o���ϐ�)
        �`�F�b�N�������l
      DMS_CondParam2(�O���[�o���ϐ�)
        NULL���A2
    �߂�l:
      DMS_CondResult(�O���[�o���ϐ�)
        DMS_CondParam2��NULL��������Axxxx�̃p�����[�^�̃`�F�b�N�l�Ƃ��āA
        �����̒l���L���Ȃ�Null�����łȂ���΁A�G���[���R�����������񂪕Ԃ�
        DMS_CondParam2��2��������Axxxx�̃p�����[�^�̃`�F�b�N�l�Ƃ��āA
        �����̒l������Ŏg���l�ɕϊ����āA���̒l���Ԃ�B
    ����:
      ��L�̒ʂ�

 ...............................................................................
*/




/*
 ...............................................................................

  �����p�����[�^�p�b�N"IMEopen"
 ...............................................................................
*/
DMS_Cond_IMEopen:
  DMS_CondResult := DMS_Cond_IMEopen_f(DMS_CondParam1)
return

DMS_Cond_IMEopen_init:
  DMS_CondResult := DMS_Cond_IMEopen_f("", DMS_CondParam1)
return

DMS_Cond_IMEopen_check:
  DMS_CondResult := DMS_Cond_IMEopen_f("", false, DMS_CondParam1,DMS_CondParam2)
return


/*
 ...............................................................................

  �����p�����[�^"IMEopen"�Ɋւ��鏈��

  �����]��
  DMS_Cond_IMEopen_f(param1)
    ����:
      param1:   �]���������l�B0��1��
    �߂�l:
      ���݂�IMEopen�̒l��param1�Ɠ����Ȃ�true,�����łȂ����false
    ����:
      �ۑ������l���Ȃ���΁AIME��Ԃ𒲂ׁA���̒l��ۑ�����
      �̂��Aparam1�Ɣ�r�B�ۑ������l������΁A�P�ɕۑ������l��param1��
      ��r���邾���B

  ������
  DMS_Cond_IMEopen_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      �ۑ������l����������

  �����̕]���l�m�F
  DMS_Cond_IMEopen_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B0��1��
    �߂�l:
      param3�̒l��0��1��������NULL�A�����łȂ���΁A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_IMEopen_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�


 ������IME�n�̃p�����[�^�p�b�N�ƁAIME�E�C���h�E��ID(DMS_CondIMEwin)���O���[�o��
   �ϐ��ŋ��L���Ă���B
   �܂��ATimeAfterChangeIMEopen�ƁA�ۑ��l(DMS_CondIMEopen)���O���[�o���ϐ���
   ���L���Ă���B
 ...............................................................................
*/
DMS_Cond_IMEopen_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEopen
  static actwin
  
  if(param1 !="")
  {
    ; �����]��

    if(DMS_CondIMEopen == "")
    {
      ; �ۑ��l���Ȃ�����

      if(!DMS_CondIMEwin)
      {
        ; IME�E�C���h�E��ID��������Ă���

        DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
      }

      ; IME open�̏�Ԃ��擾
      DetectHiddenWindows, On
      SendMessage, 0x283, 5, 0, , ahk_id %DMS_CondIMEwin%
      DMS_CondIMEopen := ErrorLevel
    }
    
    ; �]��
    if(param1 == DMS_CondIMEopen)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������
  
    ; �ۑ��l������
    DMS_CondIMEopen := ""
    
    if(actwin != param2)
    {
      ; �O��ƍ���ŃA�N�e�B�u�E�C���h�E���ς���Ă����BIME�E�C���h�EID������
      DMS_CondIMEwin := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; �]���l�`�F�b�N

    if(param3 == 0 || param3 == 1)
      return ""
    else
      return "�\���p�����[�^[IMEopen]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B���ݒ�ł���l��0��1�ł��B"
  }
}


/*
 ...............................................................................

  �����p�����[�^�p�b�N"IMEconv"
 ...............................................................................
*/

DMS_Cond_IMEconv:
  DMS_CondResult := DMS_Cond_IMEconv_f(DMS_CondParam1)
return

DMS_Cond_IMEconv_init:
  DMS_CondResult := DMS_Cond_IMEconv_f("", DMS_CondParam1)
return

DMS_Cond_IMEconv_check:
  DMS_CondResult := DMS_Cond_IMEconv_f("", false, DMS_CondParam1,DMS_CondParam2)
return


/*
 ...............................................................................

  �����p�����[�^"IMEconv"�Ɋւ��鏈��

  �����]��
  DMS_Cond_IMEconv_f(param1)
    ����:
      param1:   �]���������l�B1����5�܂�
    �߂�l:
      ���݂�IME conversion(���̓��[�h)�̒l��param1�Ɠ����Ȃ�true,
      �����łȂ����false�B
    ����:
      �ۑ������l���Ȃ���΁AIME��Ԃ𒲂ׁA���̒l��ۑ�����
      �̂��Aparam1�Ɣ�r�B�ۑ������l������΁A�P�ɕۑ������l��param1��
      ��r���邾���B
      IME�̓��̓��[�h��param1�Ƃ́A�ȉ��ɑΉ�����B
        ���p��            16
        ����              19
        �S�p��            24
        �Ђ炪��          25
        �S�J�^�J�i        27

  ������
  DMS_Cond_IMEconv_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      �ۑ������l����������

  �����̕]���l�m�F
  DMS_Cond_IMEconv_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B1����5�܂�
    �߂�l:
      param3�̒l��1����5��������NULL�A�����łȂ���΁A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_IMEconv_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3��1����5�܂ł̒l���A16,19,24,25,27�̒l�ɕϊ�����B
    ����:
      ��L�̒ʂ�


 ������IME�n�̃p�����[�^�p�b�N�ƁAIME�E�C���h�E��ID(DMS_CondIMEwin)���O���[�o��
   �ϐ��ŋ��L���Ă���B
   �܂��ATimeAfterChangeIMEconv�ƁA�ۑ��l(DMS_CondIMEconv)���O���[�o���ϐ���
   ���L���Ă���B
 ...............................................................................
*/
DMS_Cond_IMEconv_f(param1, param2 = false, param3 = false, param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEconv
  static actwin
  
  if(param1 !="")
  {
    ; �����]��

    if(DMS_CondIMEconv == "")
    {
      ; �ۑ��l���Ȃ�����

      if(!DMS_CondIMEwin)
      {
        ; IME�E�C���h�E��ID��������Ă���

        DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
      }

      ; IME conversion�̏�Ԃ��擾
      DetectHiddenWindows, On
      SendMessage, 0x283, 1, 0, , ahk_id %DMS_CondIMEwin%

      DMS_CondIMEconv := ErrorLevel & 0xff
    }

    ; �]��
    if(param1 == DMS_CondIMEconv)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������
  
    ; �ۑ��l������
    DMS_CondIMEconv := ""
    
    if(actwin != param2)
    {
      ; �O��ƍ���ŃA�N�e�B�u�E�C���h�E���ς���Ă����BIME�E�C���h�EID������

      DMS_CondIMEwin := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
    {
      ; conversion(���̓��[�h)�́A�ȉ��̒l�����݂����Ȃ̂ŁA1����5�ɒ���
;      code := "16,19,24,25,27"
      code := "0,3,8,9,11,16,19,24,25,27"
      Loop, parse, code, `,
      {
        if(param3 == A_Index)
        {
          param3 := A_LoopField
          break
        }
      }
      return param3
    }
    ; �]���l�`�F�b�N
;    if(param3 >= 1 && param3 <= 5)
    if(param3 >= 1 && param3 <= 10)
      return ""
    else
      return "�\���p�����[�^[IMEconv]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B���ݒ�ł���l��1����5�܂łł��B"
  }
}


/*
 ...............................................................................

  �����p�����[�^�p�b�N"IMEsentence"
 ...............................................................................
*/

DMS_Cond_IMEsentence:
  DMS_CondResult := DMS_Cond_IMEsentence_f(DMS_CondParam1)
return

DMS_Cond_IMEsentence_init:
  DMS_CondResult := DMS_Cond_IMEsentence_f("", DMS_CondParam1)
return

DMS_Cond_IMEsentence_check:
  DMS_CondResult := DMS_Cond_IMEsentence_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"IMEsentence"�Ɋւ��鏈��

  �����]��
  DMS_Cond_IMEsentence_f(param1)
    ����:
      param1:   �]���������l�B1����4�̐���
    �߂�l:
      ���݂�IME sentence(�ϊ����[�h)�̒l��param1�Ɠ����Ȃ�true,
      �����łȂ����false
    ����:
      �ۑ������l���Ȃ���΁AIME��Ԃ𒲂ׁA���̒l��ۑ�����
      �̂��Aparam1�Ɣ�r�B�ۑ������l������΁A�P�ɕۑ������l��param1��
      ��r���邾���B
      IME�̕ϊ����[�h��param1�Ƃ́A�ȉ��ɑΉ�����B
        ���ϊ�            0
        �l��/�n��         1
        ���              8
        �b�����t�D��      16

  ������
  DMS_Cond_IMEsentence_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      �ۑ������l����������

  �����̕]���l�m�F
  DMS_Cond_IMEsentence_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B1����4�܂ł̐���
    �߂�l:
      param3�̒l��1����4��������NULL�A�����łȂ���΁A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_IMEsentence_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3��1����4�܂ł̐������A0,1,8,16�̒l�ɕϊ�����B
    ����:
      ��L�̒ʂ�


 ������IME�n�̃p�����[�^�p�b�N�ƁAIME�E�C���h�E��ID(DMS_CondIMEwin)���O���[�o��
   �ϐ��ŋ��L���Ă���B
   �܂��ATimeAfterChangeIMEsentence�ƁA�ۑ��l(DMS_CondIMEsentence)��
   �O���[�o���ϐ��ŋ��L���Ă���B
 ...............................................................................
*/
DMS_Cond_IMEsentence_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEsentence
  static actwin
  
  if(param1 !="")
  {
    ; �����]��

    if(DMS_CondIMEsentence == "")
    {
      ; �ۑ��l���Ȃ�����

      if(!DMS_CondIMEwin)
      {
        ; IME�E�C���h�E��ID��������Ă���

        DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
      }

      ; IME sentence�̏�Ԃ��擾
      DetectHiddenWindows, On
      SendMessage, 0x283, 3, 0, , ahk_id %DMS_CondIMEwin%
      DMS_CondIMEsentence := ErrorLevel & 0xff
    }

    ; �]��
    if(param1 == DMS_CondIMEsentence)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������
  
    ; �ۑ��l������
    DMS_CondIMEsentence := ""
    
    if(actwin != param2)
    {
      ; �O��ƍ���ŃA�N�e�B�u�E�C���h�E���ς���Ă����BIME�E�C���h�EID������

      DMS_CondIMEwin := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
    {
      ; sentence(�ϊ����[�h)�́A�ȉ��̒l�����݂����Ȃ̂ŁA1����4��ϊ�����
      code := "0,1,8,16"
      Loop, parse, code, `,
      {
        if(param3 == A_Index)
        {
          param3 := A_LoopField
          break
        }
      }
      return param3
    }

    ; �]���l�`�F�b�N

    if(param3 >= 1 && param3 <= 4)
      return ""
    else
      return "�\���p�����[�^[IMEsentence]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B���ݒ�ł���l��1����4�܂łł��B"
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"WinTitle"
 ...............................................................................
*/
DMS_Cond_WinTitle:
  DMS_CondResult := DMS_Cond_WinTitle_f(DMS_CondParam1)
return

DMS_Cond_WinTitle_init:
  DMS_CondResult := DMS_Cond_WinTitle_f("", DMS_CondParam1)
return

DMS_Cond_WinTitle_check:
  DMS_CondResult := DMS_Cond_WinTitle_f("", false, DMS_CondParam1,DMS_CondParam2)
return


/*
 ...............................................................................

  �����p�����[�^"WinTitle"�Ɋւ��鏈��

  �����]��
  DMS_Cond_WinTitle_f(param1)
    ����:
      param1:   �E�C���h�E�̃^�C�g���Ɋ܂܂�镶����
    �߂�l:
      ���݂̃A�N�e�B�u�E�C���h�E�̃^�C�g����param1���܂܂��Ȃ�true�A
      �����łȂ��Ȃ�false
    ����:
      �ۑ������E�C���h�E�^�C�g�����Ȃ���΁A���݃A�N�e�B�u�̃E�C���h�E�^�C�g����
      ���ׁA���̒l��ۑ������̂��Aparam1�Ɣ�r�B�ۑ������E�C���h�E�^�C�g����
      ����΁A�P�ɕۑ������l��param1���r���邾���B

  ������
  DMS_Cond_WinTitle_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      �ۑ������l���������邾���B

  �����̕]���l�m�F
  DMS_Cond_WinTitle_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�C�ӂ̕�����
    �߂�l:
      ���NULL��Ԃ��B
    ����:
      �u�E�C���h�E�̃^�C�g���Ɋ܂܂�镶����v�́A�ǂ̂悤�Ȃ��̂��l������
      �̂ŁA�m�F���ł��Ȃ��B���ׂĖ��Ȃ��Ƃ��Ă���B

  �����̕]���l�̕ϊ�
  DMS_Cond_WinTitle_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�

 ...............................................................................
*/
DMS_Cond_WinTitle_f(param1, param2 = false, param3 = false,param4 = false)
{
  static actwin
  static wintitle
  
  if(param1 != "")
  {
    ; �����]��

    if(!wintitle)
    {
      ; �ۑ��l���Ȃ������̂ŁA�E�C���h�E�^�C�g�����擾���āA�ۑ�
      WinGetTitle, wintitle, ahk_id %actwin%
    }

    ; �]��
    IfInString, wintitle, %param1%
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������

    if(actwin != param2)
    {
      ; �O��ƍ���ŃA�N�e�B�u�E�C���h�E���ς���Ă�����A
      ; �ۑ����Ă������E�C���h�E�^�C�g��������
      wintitle := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
      return param3

    ; �]���l�̃`�F�b�N�́A��Ɂu���Ȃ��v�Ń��^�[��
    return ""
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"WinClass"
 ...............................................................................
*/
DMS_Cond_WinClass:
  DMS_CondResult := DMS_Cond_WinClass_f(DMS_CondParam1)
return

DMS_Cond_WinClass_init:
  DMS_CondResult := DMS_Cond_WinClass_f("", DMS_CondParam1)
return

DMS_Cond_WinClass_check:
  DMS_CondResult := DMS_Cond_WinClass_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"WinClass"�Ɋւ��鏈��

  �����]��
  DMS_Cond_WinClass_f(param1)
    ����:
      param1:   �E�C���h�E�̃N���X���Ɋ܂܂�镶����
    �߂�l:
      ���݂̃A�N�e�B�u�E�C���h�E�̃N���X����param1���܂܂��Ȃ�true�A
      �����łȂ��Ȃ�false
    ����:
      �ۑ������N���X�����Ȃ���΁A���݃A�N�e�B�u�̃E�C���h�E�N���X����
      ���ׁA���̒l��ۑ������̂��Aparam1�Ɣ�r�B�ۑ������N���X����
      ����΁A�P�ɕۑ������l��param1���r���邾���B

  ������
  DMS_Cond_WinClass_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      �ۑ������l���������邾���B

  �����̕]���l�m�F
  DMS_Cond_WinClass_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�C�ӂ̕�����
    �߂�l:
      ���NULL��Ԃ��B
    ����:
      �u�E�C���h�E�̃N���X���Ɋ܂܂�镶����v�́A�ǂ̂悤�Ȃ��̂��l������
      �̂ŁA�m�F���ł��Ȃ��B���ׂĖ��Ȃ��Ƃ��Ă���B

  �����̕]���l�̕ϊ�
  DMS_Cond_WinClass_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�

 ...............................................................................
*/
DMS_Cond_WinClass_f(param1, param2 = false, param3 = false,param4 = false)
{
  static actwin
  static winclass
  
  if(param1 != "")
  {
    ; �����]��

    if(!winclass)
    {
      ; �ۑ��l���Ȃ������̂ŁA�N���X�����擾���āA�ۑ�
      WinGetClass, winclass, ahk_id %actwin%
    }

    ; �]��
    IfInString, winclass, %param1%
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������

    if(actwin != param2)
    {
      ; �O��ƍ���ŃA�N�e�B�u�E�C���h�E���ς���Ă�����A
      ; �ۑ����Ă������E�C���h�E�^�C�g��������
      winclass := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
      return param3

    ; �]���l�̃`�F�b�N�́A��Ɂu���Ȃ��v�Ń��^�[��
    return ""
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"Control"
 ...............................................................................
*/
DMS_Cond_Control:
  DMS_CondResult := DMS_Cond_Control_f(DMS_CondParam1)
return

DMS_Cond_Control_init:
  DMS_CondResult := DMS_Cond_Control_f("", DMS_CondParam1)
return

DMS_Cond_Control_check:
  DMS_CondResult := DMS_Cond_Control_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"Control"�Ɋւ��鏈��

  �����]��
  DMS_Cond_Control_f(param1)
    ����:
      param1:   ClassNN�Ɋ܂܂�镶����
    �߂�l:
      ���݂̃A�N�e�B�u�R���g���[���̖��O(ClassNN)��param1���܂܂��Ȃ�true�A
      �����łȂ��Ȃ�false
    ����:
      �ۑ�����ClassNN���Ȃ���΁A���݃A�N�e�B�u�̃R���g���[����ClassNN��
      ���ׁA���̒l��ۑ������̂��Aparam1�Ɣ�r�B�ۑ������E�C���h�E�^�C�g����
      ����΁A�P�ɕۑ������l��param1���r���邾���B

  ������
  DMS_Cond_Control_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      �ۑ������l���������邾���B

  �����̕]���l�m�F
  DMS_Cond_Control_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�C�ӂ̕�����
    �߂�l:
      ���NULL��Ԃ��B
    ����:
      �uClassNN�Ɋ܂܂�镶����v�́A�ǂ̂悤�Ȃ��̂��l������
      �̂ŁA�m�F���ł��Ȃ��B���ׂĖ��Ȃ��Ƃ��Ă���B

  �����̕]���l�̕ϊ�
  DMS_Cond_Control_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�

 ...............................................................................
*/
DMS_Cond_Control_f(param1, param2 = false, param3 = false,param4 = false)
{
  static actwin
  static cntrl
  
  if(param1 != "")
  {
    ; �����]��

    if(!cntrl)
    {
      ; �ۑ��l���Ȃ������̂ŁAClassNN���擾���āA�ۑ�
      ;ControlGetFocus, cntrl, ahk_id %actwin%
      ; ������ControlGetFocus���g���ƁA���̃R�}���h�́A������AttachThreadInput
      ; ���ĂԂ̂ŁA���ׂ������Ȃ�B
      ; �����ŁACAR_GetCaretPos()�œ���ꂽ�R���g���[����ID�����炤���ƂŁA
      ; ControlGetFocus���R�[�����邱�Ƃ��������B
      cntrl_id := CAR_GetCaretPos(false,dummy,dummy)
      WinGetClass, cntrl, ahk_id %cntrl_id%
    }

    ; �]��
    IfInString, cntrl, %param1%
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������
    ; �Ƃɂ����A�ۑ�����ClassNN������

    cntrl := false
    actwin := param2
    return
  }
  else
  {
    if(param4 == 2)
      return param3
      
    ; �]���l�̃`�F�b�N�́A��Ɂu���Ȃ��v�Ń��^�[��
    return ""
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"TimeAfterChangeIMEopen"
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEopen:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEopen_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEopen_init:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEopen_f("", DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEopen_check:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEopen_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"TimeAfterChangeIMEopen"�Ɋւ��鏈��

  �����]��
  DMS_Cond_TimeAfterChangeIMEopen_f(param1)
    ����:
      param1:   �]���������l�B0�ȏ�(�~���b)
    �߂�l:
      ���݂�IMEopen�̒l���A�̂�IMEopen�̒l�Ɠ����ŁA�̂�IMEopen�̂Ƃ������
      �o�ߎ��Ԃ��Aparam1�����傫��������Atrue�A�����łȂ����false��Ԃ��B
    ����:
      ���݂�IMEopen�̒l(=nowIMEopen)���ۑ����ĂȂ���΁A
      �܂��AIME��Ԃ𒲂ׁA���̒l��ۑ�����B���̂Ƃ��ɁA���݂̎��Ԃ��ۑ�
      (nowTime)
      �̂�IMEopen�̒l(=lastIMEopen)��nowIMEopen���قȂ�A���邢�́A�̂̎���
      (lastTime)���ۑ�����ĂȂ�������AlastIMEopen�ƁAlastTime���A���݂̂��̂�
      �ݒ�B
      ���ꂩ��AnowTime��lastTime�̍����Aparam1���傫�����ǂ����`�F�b�N���āA
      �傫��������Atrue��Ԃ��A�����łȂ����false��Ԃ��B

  ������
  DMS_Cond_TimeAfterChangeIMEopen_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      nowIMEopen����������B
      ����ɁA���������ꂽ���ƂɁA��x�ł���L�́u�����]���v���Ă΂ꂽ����
      ����킷"evaluated"��false��������AlastTime����������B

  �����̕]���l�m�F
  DMS_Cond_TimeAfterChangeIMEopen_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�~���b
    �߂�l:
      param3�̒l��0�ȏゾ������NULL�A�}�C�i�X��������A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_TimeAfterChangeIMEopen_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�

 ������IME�n�̃p�����[�^�p�b�N�ƁAIME�E�C���h�E��ID(DMS_CondIMEwin)���O���[�o��
   �ϐ��ŋ��L���Ă���B
   �܂��AIMEopen�ƁA�ۑ��l(DMS_CondIMEopen)���O���[�o���ϐ��ŋ��L���Ă���B
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEopen_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEopen
  static lastIMEopen
  static nowIMEopen
  static lastTime
  static nowTime
  static actwin
  static evaluated
  
  if(param1 !="")
  {
    ; �����]��

    if(nowIMEopen == "")
    {
      ; ���݂�IME��Ԃ�ۑ������ۑ��l���Ȃ������B
      if(DMS_CondIMEopen == "")
      {
        ; "IMEopen"�Ƌ��L���Ă���ۑ��l���󂾂����B�����Œ��ׂȂ����Ⴂ���Ȃ�
        if(!DMS_CondIMEwin)
          ; IME�E�C���h�E���󂾂����B�����Ŏ擾
          DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
  
        ; IME��open��Ԃ��擾
        DetectHiddenWindows, On
        SendMessage, 0x283, 5, 0, , ahk_id %DMS_CondIMEwin%
        DMS_CondIMEopen := ErrorLevel
      }
      
      ; ���݂�IME��Ԃ��A���LIMEopen�l(DMS_CondIMEopen)�ɐݒ�
      nowIMEopen := DMS_CondIMEopen
      ; ���݂̎������v��
      nowTime := A_TickCount
    }
    
    if(!lastTime || lastIMEopen != nowIMEopen)
    {
      ; �ߋ��ƌ��݂�IME��Ԃ��Ⴄ�A���邢�́A�ߋ��̎������L�^����ĂȂ��B
      ; �ߋ��̒l�̐ݒ�(���݂Ɠ����ɂ���)
      lastTime := nowTime
      lastIMEopen := nowIMEopen
    }

    ; �u�����]���v���s��ꂽ���Ƃ����߂��ϐ���true��
    evaluated := true

    ; �]��
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������

    ; �ۑ��l���N���A
    DMS_CondIMEopen := ""
    nowIMEopen := ""
    
    if(actwin != param2)
    {
      ; �A�N�e�B�u�E�C���h�E���ς���Ă����Ƃ��́AIME�E�C���h�E�����������Ȃ̂�
      ; �N���A�B���R�A�ߋ��̌v�����Ԃ������Ȃ̂ŃN���A
      DMS_CondIMEwin := false
      actwin := param2
      lastTime := false
    }
    
    if(!evaluated)
    {
      ; ��x���u�����]���v���R�[������ĂȂ������B���Ԍv����ł��؂邽�߂ɁA
      ; �ߋ����Ԃ��N���A����B
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; �]���l�̃`�F�b�N�B���̒l�Ȃ���Ȃ�
    if(param3 >= 0)
      return ""
    else
      return "�\���p�����[�^[TimeAfterChangeIMEopen]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l��0�ȏ�ł��B"
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"TimeAfterChangeIMEconv"
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEconv:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEconv_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEconv_init:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEconv_f("", DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEconv_check:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEconv_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"TimeAfterChangeIMEconv"�Ɋւ��鏈��

  �����]��
  DMS_Cond_TimeAfterChangeIMEconv_f(param1)
    ����:
      param1:   �]���������l�B0�ȏ�(�~���b)
    �߂�l:
      ���݂�IMEconv�̒l���A�̂�IMEconv�̒l�Ɠ����ŁA�̂�IMEconv�̂Ƃ������
      �o�ߎ��Ԃ��Aparam1�����傫��������Atrue�A�����łȂ����false��Ԃ��B
    ����:
      ���݂�IMEconv�̒l(=nowIMEconv)���ۑ����ĂȂ���΁A
      �܂��AIME��Ԃ𒲂ׁA���̒l��ۑ�����B���̂Ƃ��ɁA���݂̎��Ԃ��ۑ�
      (nowTime)
      �̂�IMEconv�̒l(=lastIMEconv)��nowIMEconv���قȂ�A���邢�́A�̂̎���
      (lastTime)���ۑ�����ĂȂ�������AlastIMEconv�ƁAlastTime���A���݂̂��̂�
      �ݒ�B
      ���ꂩ��AnowTime��lastTime�̍����Aparam1���傫�����ǂ����`�F�b�N���āA
      �傫��������Atrue��Ԃ��A�����łȂ����false��Ԃ��B

  ������
  DMS_Cond_TimeAfterChangeIMEconv_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      nowIMEconv����������B
      ����ɁA���������ꂽ���ƂɁA��x�ł���L�́u�����]���v���Ă΂ꂽ����
      ����킷"evaluated"��false��������AlastTime����������B

  �����̕]���l�m�F
  DMS_Cond_TimeAfterChangeIMEconv_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�~���b
    �߂�l:
      param3�̒l��0�ȏゾ������NULL�A�}�C�i�X��������A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_TimeAfterChangeIMEconv_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�


 ������IME�n�̃p�����[�^�p�b�N�ƁAIME�E�C���h�E��ID(DMS_CondIMEwin)���O���[�o��
   �ϐ��ŋ��L���Ă���B
   �܂��AIMEconv�ƁA�ۑ��l(DMS_CondIMEconv)���O���[�o���ϐ��ŋ��L���Ă���B
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEconv_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEconv
  static lastIMEconv
  static nowIMEconv
  static lastTime
  static nowTime
  static actwin
  static evaluated
  
  if(param1 !="")
  {
    ; �����]��

    if(nowIMEconv == "")
    {
      ; ���݂�IME��Ԃ�ۑ������ۑ��l���Ȃ������B
      if(DMS_CondIMEconv == "")
      {
        ; "IMEconv"�Ƌ��L���Ă���ۑ��l���󂾂����B�����Œ��ׂȂ����Ⴂ���Ȃ�
        if(!DMS_CondIMEwin)
          ; IME�E�C���h�E���󂾂����B�����Ŏ擾
          DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
  
        ; IME�̓��̓��[�h���擾
        DetectHiddenWindows, On
        SendMessage, 0x283, 1, 0, , ahk_id %DMS_CondIMEwin%
        
        ; ���̓��[�h���A1����5�̒l�ɕϊ�
;        code := "16,19,24,25,27"
        code := "0,3,8,9,11,16,19,24,25,27"
        org_code := ErrorLevel & 0xff
        Loop, parse, code, `,
        {
          if(org_code == A_LoopField)
          {
            DMS_CondIMEconv := A_Index
            break
          }
        }
      }

      ; ���݂̒l�Ǝ������L�^
      nowIMEconv := DMS_CondIMEconv
      nowTime := A_TickCount
    }

    if(!lastTime || lastIMEconv != nowIMEconv)
    {
      ; �ߋ��ƌ��݂�IME��Ԃ��Ⴄ�A���邢�́A�ߋ��̎������L�^����ĂȂ��B
      ; �ߋ��̒l�̐ݒ�(���݂Ɠ����ɂ���)
      lastTime := nowTime
      lastIMEconv := nowIMEconv
    }
      
    ; �u�����]���v���s��ꂽ���Ƃ����߂��ϐ���true��
    evaluated := true

    ; �]��
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������

    ; �ۑ��l���N���A
    DMS_CondIMEconv := ""
    nowIMEconv := ""
    
    if(actwin != param2)
    {
      ; �A�N�e�B�u�E�C���h�E���ς���Ă����Ƃ��́AIME�E�C���h�E�����������Ȃ̂�
      ; �N���A�B���R�A�ߋ��̌v�����Ԃ������Ȃ̂ŃN���A

      DMS_CondIMEwin := false
      actwin := param2
      lastTime := false
    }
    
    if(!evaluated)
    {
      ; ��x���u�����]���v���R�[������ĂȂ������B���Ԍv����ł��؂邽�߂ɁA
      ; �ߋ����Ԃ��N���A����B
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3

    ; �]���l�̃`�F�b�N�B���̒l�Ȃ���Ȃ�
    if(param3 >= 0)
      return ""
    else
      return "�\���p�����[�^[TimeAfterChangeIMEconv]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l��0�ȏ�ł��B"
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"TimeAfterChangeIMEsentence"
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEsentence:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEsentence_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEsentence_init:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEsentence_f("", DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEsentence_check:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEsentence_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"TimeAfterChangeIMEsentence"�Ɋւ��鏈��

  �����]��
  DMS_Cond_TimeAfterChangeIMEsentence_f(param1)
    ����:
      param1:   �]���������l�B0�ȏ�(�~���b)
    �߂�l:
      ���݂�IMEsentence�̒l���A�̂�IMEsentence�̒l�Ɠ����ŁA
      �̂�IMEsentence�̂Ƃ�����̌o�ߎ��Ԃ��Aparam1�����傫��������A
      true�A�����łȂ����false��Ԃ��B
    ����:
      ���݂�IMEsentence�̒l(=nowIMEsentence)���ۑ����ĂȂ���΁A
      �܂��AIME��Ԃ𒲂ׁA���̒l��ۑ�����B���̂Ƃ��ɁA���݂̎��Ԃ��ۑ�
      (nowTime)
      �̂�IMEsentence�̒l(=lastIMEsentence)��nowIMEsentence���قȂ�A
      ���邢�́A�̂̎���(lastTime)���ۑ�����ĂȂ�������AlastIMEsentence�ƁA
      lastTime���A���݂̂��̂ɐݒ�B
      ���ꂩ��AnowTime��lastTime�̍����Aparam1���傫�����ǂ����`�F�b�N���āA
      �傫��������Atrue��Ԃ��A�����łȂ����false��Ԃ��B

  ������
  DMS_Cond_TimeAfterChangeIMEsentence_f("", param2)
    ����:
      "":       ���NULL
      param2:   �A�N�e�B�u�ȃE�C���h�E��ID
    �߂�l:
      �Ȃ�
    ����:
      nowIMEsentence����������B
      ����ɁA���������ꂽ���ƂɁA��x�ł���L�́u�����]���v���Ă΂ꂽ����
      ����킷"evaluated"��false��������AlastTime����������B

  �����̕]���l�m�F
  DMS_Cond_TimeAfterChangeIMEsentence_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�~���b
    �߂�l:
      param3�̒l��0�ȏゾ������NULL�A�}�C�i�X��������A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_TimeAfterChangeIMEsentence_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�

 ������IME�n�̃p�����[�^�p�b�N�ƁAIME�E�C���h�E��ID(DMS_CondIMEwin)���O���[�o��
   �ϐ��ŋ��L���Ă���B
   �܂��AIMEsentence�ƁA�ۑ��l(DMS_CondIMEsentence)���O���[�o���ϐ��ŋ��L���Ă���B
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEsentence_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEsentence
  static lastIMEsentence
  static nowIMEsentence
  static lastTime
  static nowTime
  static actwin
  static evaluated
  
  if(param1 !="")
  {
    ; �����]��

    if(nowIMEsentence == "")
    {
      ; ���݂�IME��Ԃ�ۑ������ۑ��l���Ȃ������B
      if(DMS_CondIMEsentence == "")
      {
        ; "IMEconv"�Ƌ��L���Ă���ۑ��l���󂾂����B�����Œ��ׂȂ����Ⴂ���Ȃ�
        if(!DMS_CondIMEwin)
          ; IME�E�C���h�E���󂾂����B�����Ŏ擾
          DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)

        ; IME�̕ϊ����[�h���擾
        DetectHiddenWindows, On
        SendMessage, 0x283, 3, 0, , ahk_id %DMS_CondIMEwin%
        
        ; �ϊ����[�h���A1����4�̒l�ɕϊ�
        code := "0,1,8,16"
        org_code := ErrorLevel & 0xff
        Loop, parse, code, `,
        {
          if(org_code == A_LoopField)
          {
            DMS_CondIMEsentence := A_Index
            break
          }
        }
      }

      ; ���݂̒l�Ǝ������L�^
      nowIMEsentence := DMS_CondIMEsentence
      nowTime := A_TickCount
    }
    
    if(!lastTime || lastIMEsentence != nowIMEsentence)
    {
      ; �ߋ��ƌ��݂�IME��Ԃ��Ⴄ�A���邢�́A�ߋ��̎������L�^����ĂȂ��B
      ; �ߋ��̒l�̐ݒ�(���݂Ɠ����ɂ���)
      lastTime := nowTime
      lastIMEsentence := nowIMEsentence
    }

    ; �u�����]���v���s��ꂽ���Ƃ����߂��ϐ���true��
    evaluated := true

    ; �]��
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������

    ; �ۑ��l���N���A
    DMS_CondIMEsentence := ""
    nowIMEsentence := ""
    
    if(actwin != param2)
    {
      ; �A�N�e�B�u�E�C���h�E���ς���Ă����Ƃ��́AIME�E�C���h�E�����������Ȃ̂�
      ; �N���A�B���R�A�ߋ��̌v�����Ԃ������Ȃ̂ŃN���A
      DMS_CondIMEwin := false
      actwin := param2
      lastTime := false
    }
    
    if(!evaluated)
    {
      ; ��x���u�����]���v���R�[������ĂȂ������B���Ԍv����ł��؂邽�߂ɁA
      ; �ߋ����Ԃ��N���A����B
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; �]���l�̃`�F�b�N�B���̒l�Ȃ���Ȃ�
    if(param3 >= 0)
      return ""
    else
      return "�\���p�����[�^[TimeAfterChangeIMEsentence]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l��0�ȏ�ł��B"
  }
}

/*
 ...............................................................................

  �����p�����[�^�p�b�N"TimeAfterStopCaret"
 ...............................................................................
*/
DMS_Cond_TimeAfterStopCaret:
  DMS_CondResult := DMS_Cond_TimeAfterStopCaret_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterStopCaret_init:
  DMS_CondResult := DMS_Cond_TimeAfterStopCaret_f("", DMS_CondParam2,DMS_CondParam3)
return

DMS_Cond_TimeAfterStopCaret_check:
  DMS_CondResult := DMS_Cond_TimeAfterStopCaret_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  �����p�����[�^"TimeAfterStopCaret"�Ɋւ��鏈��

  �����]��
  DMS_Cond_TimeAfterStopCaret_f(param1)
    ����:
      param1:   �]���������l�B0�ȏ�(�~���b)
    �߂�l:
      ���݂̃L�����b�g�̍��W�l���A�̂̃L�����b�g�̍��W�l�Ɠ����ŁA
      �̂̃L�����b�g�̍��W�l�̂Ƃ�����̌o�ߎ��Ԃ��Aparam1�����傫��������A
      true�A�����łȂ����false��Ԃ��B
    ����:
      ���݂̎��Ԃ��ۑ�����ĂȂ�������A�܂������ݒ�(nowTime)
      ���݂̃L�����b�g�̍��W�l���A�̂̃L�����b�g�̍��W�l�ƈقȂ�
      ���邢�́A�̂̎���(lastTime)���ۑ�����ĂȂ�������A�̂̃L�����b�g���W�l��
      lastTime���A���݂̂��̂ɐݒ�B
      ���ꂩ��AnowTime��lastTime�̍����Aparam1���傫�����ǂ����`�F�b�N���āA
      �傫��������Atrue��Ԃ��A�����łȂ����false��Ԃ��B

  ������
  DMS_Cond_TimeAfterStopCaret_f("", param2, param3)
    ����:
      "":       ���NULL
      param2:   �L�����b�gx���W
      param3:   �L�����b�gy���W
    �߂�l:
      �Ȃ�
    ����:
      ���ݎ���(nowTime)���N���A����B�����āA�������A���݂̃L�����b�g�l��
      �ݒ肷��B
      ����ɁA���������ꂽ���ƂɁA��x�ł���L�́u�����]���v���Ă΂ꂽ����
      ����킷"evaluated"��false��������AlastTime����������B

  �����̕]���l�m�F
  DMS_Cond_TimeAfterStopCaret_f("", false, param3)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �`�F�b�N�������l�B�~���b
    �߂�l:
      param3�̒l��0�ȏゾ������NULL�A�}�C�i�X��������A�T�|�[�g�ł��Ȃ��|��
      ���b�Z�[�W������
    ����:
      ��L�̒ʂ�

  �����̕]���l�̕ϊ�
  DMS_Cond_TimeAfterStopCaret_f("", false, param3, 2)
    ����:
      "":       ���NULL
      false:    ���false
      param3:   �ϊ��������l
      2:        ���2
    �߂�l:
      param3�̒l������Ŏg�p����l�ɕϊ�����B
      �{�֐��ł́Aparam3�����̂܂ܕԂ��B
    ����:
      ��L�̒ʂ�

 ...............................................................................
*/
DMS_Cond_TimeAfterStopCaret_f(param1, param2 = false, param3 = false,param4 = false)
{
  static lastDsp_x
  static lastDsp_y
  static lastTime
  static nowTime
  static nowDsp_x
  static nowDsp_y
  static evaluated
  
  if(param1 !="")
  {
    ; �����]��

    if(!nowTime)
      ; ���ݎ������v������ĂȂ������̂ŁA�����Ōv��
      nowTime := A_TickCount

    if(!lastTime || lastDsp_x != nowDsp_x || lastDsp_y != nowDsp_y)
    {
      ; �ߋ��̍��W�ƌ��݂̍��W���قȂ�
      ; ���݂̍��W���ߋ��̍��W�Ƃ��āA����ɁA�ߋ��̎��Ԃ����݂̎��Ԃɐݒ�
      lastTime := nowTime
      lastDsp_x := nowDsp_x 
      lastDsp_y := nowDsp_y
    }
      
    ; �u�����]���v���s��ꂽ���Ƃ����߂��ϐ���true��
    evaluated := true

    ; �]��
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; ������

    ; �ۑ��l���N���A
    nowTime := false
    ; �����̍��W���A���݂̍��W�Ƃ��ĕۑ�����
    nowDsp_x := param2
    nowDsp_y := param3

    if(!evaluated)
    {
      ; ��x���u�����]���v���R�[������ĂȂ������B���Ԍv����ł��؂邽�߂ɁA
      ; �ߋ����Ԃ��N���A����B
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; �]���l�̃`�F�b�N�B���̒l�Ȃ���Ȃ�
    if(param3 >= 0)
      return ""
    else
      return "�\���p�����[�^[TimeAfterStopCaret]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l��0�ȏ�ł��B"
  }
}

/*
----------------------------------------------------------------------------
 6.�\���Ǘ���

   IME��ԕ\���p�̕\���p�����[�^�̊Ǘ��ƁA���̕\�����s���B

----------------------------------------------------------------------------
*/

/*
 ...............................................................

  IME��Ԃ�\������B
  
  DMS_DispIMEsts(disp)
    ����:   
      disp:    true�ŕ\���Afalse�Ŕ�\��
    �߂�l: 
      �Ȃ�
    ����:
      disp��false�Ȃ�A�c�[���`�b�v������
      true�Ȃ�ADMS_DispParameters()�ɕۑ����ꂽ�\���p�����[�^��ǂݏo���A
      ����ɏ]���\�����s��

 ...............................................................
*/  
DMS_DispIMEsts(disp)
{
  static last_disp, last_string, last_dsp_x, last_dsp_y, last_trans
  static last_grid_x, last_grid_y
  static last_normal, last_color,last_margin_x,last_margin_y,last_fontName
  static last_fontColor,last_fontSize,last_fontStyle,last_frameStyle

  tooltip_num := DMS_SystemParameters("tooltip_num")

  ; ���݂̕\���p�����[�^��ǂݏo��(1)
  ; �܂�string��ǂ�ł݂āANULL��������A�\���̂��悤���Ȃ��̂ŁA
  ; �����ă��^�[������B
  string := DMS_DispParameters("string")
  if(string == "" || !disp)
  {
    if(last_disp)
    {
      if(last_normal)
        ToolTip, , , ,%tooltip_num%
      else
        Gui, %tooltip_num%:Hide
    }
    last_disp := false
    return
  }



  
  ; ���݂̕\���p�����[�^��ǂݏo��(2)
  dsp_x := DMS_DispParameters("dsp_x")
  dsp_x := dsp_x + DMS_DispParameters("ofst_x")

  dsp_y := DMS_DispParameters("dsp_y")
  dsp_y := dsp_y + DMS_DispParameters("ofst_y")

  trans := DMS_DispParameters("trans")

  grid_x := DMS_DispParameters("grid_x")
  grid_y := DMS_DispParameters("grid_y")

  normal := DMS_DispParameters("normal")
  ; normal����Ȃ��ꍇ�̂݁A�J�X�^���\���̃p�����[�^�ǂݏo��
  if(!normal)
  {
    color  := DMS_DispParameters("color")
    margin_x := DMS_DispParameters("margin_x")
    margin_y := DMS_DispParameters("margin_y")
    fontName := DMS_DispParameters("fontName")
    fontColor:= DMS_DispParameters("fontColor")
    fontSize := DMS_DispParameters("fontSize")
    fontStyle := DMS_DispParameters("fontStyle")
    frameStyle := DMS_DispParameters("frameStyle")
    
    ; �\�����e���ω��������`�F�b�N���āA�ω����Ă�����A�V����Gui���쐬����
    if(last_color != color || last_margin_x != margin_x || last_margin_y != margin_y || last_fontName != fontName || last_fontColor != fontColor || last_fontSize != fontSize || last_fontStyle != fontStyle || last_string!=string || last_normal!=normal || last_frameStyle != frameStyle)
    {
      ; �V����Gui���쐬����B
      Gui, %tooltip_num%:Destroy

      Gui, %tooltip_num%:Margin, %margin_x%,%margin_y%
      Gui, %tooltip_num%:Color, %color%
      Gui, %tooltip_num%:Font, %fontStyle%
      if(fontColor != "")
        Gui, %tooltip_num%:Font, C%fontColor%
      if(fontSize != "")
        Gui, %tooltip_num%:Font, S%fontSize%
      if(fontName != "")
        Gui, %tooltip_num%:Font, , %fontName%
      Gui, %tooltip_num%:Add, Text,,%string%
      Gui, %tooltip_num%:+AlwaysOnTop +Disabled +ToolWindow %frameStyle%
      
      ; ���̏ꍇ�A�K���\�����Ȃ���΂Ȃ�Ȃ��̂ŁAlast_disp��false�ɂ���B
      ; ���̎��_��disp��true�Ȃ̂ŁA���̉��Ő�΂ɕ\�����Ă����
      last_disp := false
    }
  }
  
  ; �ߋ��̕\���p�����[�^�Ɣ�r���āA�ω����Ȃ�������A�Ȃɂ��������^�[��
  if(last_dsp_x == dsp_x && last_dsp_y == dsp_y && last_disp == disp && last_string == string && last_trans == trans && last_grid_x == grid_x && last_grid_y == grid_y && last_normal == normal)
    return


  ; �����Anormal���ς���Ă�����A�O�̕\���͏����Ă����Ȃ��Ƃ����Ȃ�
  if(last_normal != normal)
  {
    if(last_normal)
      ToolTip, , , ,%tooltip_num%
    else
      Gui, %tooltip_num%:Hide
  }

  ; �ߋ��̕\���p�����[�^�����݂̕\���p�����[�^�ɐݒ�
  last_disp := disp  ; �K��true�ɂȂ�
  last_string := string
  last_dsp_x := dsp_x
  last_dsp_y := dsp_y
  last_trans := trans
  last_grid_x := grid_x
  last_grid_y := grid_y
  last_normal := normal
  
  if(!normal)
  {
    last_color := color
    last_margin_x := margin_x
    last_margin_y := margin_y
    last_fontName := fontName
    last_fontColor:= fontColor
    last_fontSize := fontSize
    last_fontStyle := fontStyle
    last_frameStyle := frameStyle
  }

  if(grid_x || grid_y)
  {
    ; �O���b�h�\�����w�肳��Ă����B
    
    ; �R���g���[�����_�̃L�����b�g���W���擾
    CAR_GetCaretPos(false, org_x, org_y)
    ; �t�H�[�J�X�̂���R���g���[���̍��W�Ƒ傫�����擾
    actwin := DMS_DispParameters("actwin")
    ControlGetFocus, cntrl, ahk_id %actwin%
    ControlGetPos, cx,cy,cw,ch, %cntrl%, ahk_id %actwin%
    
    ; �A�N�e�B�u�E�C���h�E�̍��W���擾���R���g���[�����W���X�N���[�����W��
    ; ����̂Ɏg��
    WinGetPos, wx,wy,,,ahk_id %actwin%

    if(grid_x)
    {
      ; �R���g���[���̕���grid_x�Ŋ���A�i�q�̉����𓾂�B
      grid := Round(cw / grid_x)
      
      ; 0���Z������邽�߂̃`�F�b�N�̂��ƁA��ԋ߂��i�q���W���v�Z
      if(grid > 1)
        dsp_x := wx + cx + grid * Round(org_x / grid) + DMS_DispParameters("ofst_x")
    }
      
    if(grid_y)
    {
      ; grid_x�̏ꍇ�Ƃ���Ă邱�Ƃ͓����B
      grid := Round(ch / grid_y)
      if(grid > 1)
        dsp_y := wy + cy + grid * Round(org_y / grid) + DMS_DispParameters("ofst_y")
    }
  }

  if(normal)
  {
    ; �L�����b�g���W�̓X�N���[�����W�n�Ȃ̂ŁA�X�N���[�����W�n�Ńc�[���`�b�v��
    ; �o��

    CoordMode,ToolTip,Screen
    ToolTip, %string%, %dsp_x%, %dsp_y%,%tooltip_num%

    dispWin := "ahk_class tooltips_class32"
  }
  else
  {
    Gui, %tooltip_num%:Show,X%dsp_x% Y%dsp_y% NoActivate,DispIMEstatus
    dispWin := "DispIMEstatus"
  }

; �����w�肪����Ă�����AWinSet�œ������B����ĂȂ�������A�����w��Off
  if(trans)
    WinSet,Trans,%trans%,%dispWin%
  else
    WinSet,Trans,Off,%dispWin%

}

/*
 ...............................................................................

  �\���p�����[�^�̏�����(�f�t�H���g�l�ɐݒ�)
  �{�A�v����0.3�b�Ƃ��̃^�C�}�N�����Ɉ�x�R�[�������B
  
  DMS_InitDispParameters(actwin, car_x, car_y)
    ����:
      actwin:   ���݃A�N�e�B�u�ȃE�C���h�E��ID
      car_x:    �L�����b�g��x���W(�X�N���[�����W�n)
      car_y:    �L�����b�g��y���W(�X�N���[�����W�n)
    �߂�l:
      �Ȃ�
    ����:
      DMS_DispParameters(false, actwin, car_x, car_y)���R�[�����邾��

 ...............................................................................
*/
DMS_InitDispParameters(actwin, car_x, car_y)
{
  DMS_DispParameters(false, actwin, car_x, car_y)
  return
}

/*
 ...............................................................................

  �\���p�����[�^�̕ێ�

  �f�t�H���g�l�ݒ�
  DMS_DispParameters()
    ����:
      �Ȃ�
    �߂�l:
      �Ȃ�
    ����:
      �{�A�v���N�����Ɉ�x�����R�[�������B
      �f�t�H���g�l�Ǘ���(DMS_Default())�ɐݒ肳�ꂽ�l�����o���A������
      �f�t�H���g�l�Ƃ��Đݒ肷��B

  ������Ԃ��f�t�H���g�Ƀ��Z�b�g
  DMS_DispParameters(false, actwin, dsp_x, dsp_y)
    ����:
      false:    ���false
      actwin:   ���݃A�N�e�B�u�ȃE�C���h�E��ID
      car_x:    �L�����b�g��x���W(�X�N���[�����W�n)
      car_y:    �L�����b�g��y���W(�X�N���[�����W�n)
    �߂�l:
      �Ȃ�
    ����:
      �{�A�v����0.3�b�Ƃ��̃^�C�}�N�����Ɉ�x�R�[�������B
      �����̕\���p�����[�^���A�f�t�H���g�l�ɐݒ肷��B
      (���̑��A�\���ɕK�v��actwin��L�����b�g���W���ۑ����Ă���)
      ���̂܂܁Aini�t�@�C���łȂ�̕\���p�����[�^�̎w����Ȃ�������A
      ���̃f�t�H���g�l���A�\�������Ƃ����킯�B
      ���ۂɂ́A���̌�A���L�́u�p�����[�^�ݒ�v�����x���R�[������āA
      �\���p�����[�^���X�V����Ă����B�X�V����Ȃ������\���p�����[�^�́A
      �f�t�H���g�̂܂܂ł���B

  �p�����[�^�ݒ�
  DMS_DispParameters(paramName, paramVal, true)
    ����:
      paramName: �\���p�����[�^��
      paramVal:  �p�����[�^�̒l
      true:      ���true
    �߂�l:
      �Ȃ�
    ����:
      �\���p�����[�^paramName���AparamVal�ɐݒ肷��B

  �p�����[�^�ǂݏo��
  DMS_DispParameters(paramName)
    ����:
      paramName: �\���p�����[�^��
    �߂�l:
      paramName�̃p�����[�^�̒l��Ԃ�
    ����:
      paramName�̃p�����[�^�̒l��Ԃ�

  �p�����[�^���̃T�|�[�g�m�F
  DMS_DispParameters(false, false, paramName)
    ����:
      false:     ���false
      false:     ���false
      paramName: �\���p�����[�^��
    �߂�l:
      paramName���T�|�[�g���Ă���\���p�����[�^���ł�������true�A
      �����łȂ���΁Afalse
    ����:
      paramName�̖��O�̃p�����[�^���������ł��邩�ǂ����`�F�b�N����B

  �p�����[�^�̐ݒ�l�m�F
  DMS_DispParameters(false, false, paramName, paramVal, 1)
    ����:
      false:     ���false
      false:     ���false
      paramName: �\���p�����[�^��
      paramVal:  �ݒ肵�悤�Ƃ���l
      1:         �˂�1
    �߂�l:
      paramName�Ƃ������O�̕\���p�����[�^���AparamVal�Ƃ����l��ݒ�ł����
      NULL�A�ݒ�ł��Ȃ���΁A����������������Ԃ��B
    ����:
      paramName���ƂɁA�ݒ�l�͈̔͂��m�F����B

  �p�����[�^�l�̕ϊ�
  DMS_DispParameters(false, false, paramName, paramVal, 2)
    ����:
      false:     ���false
      false:     ���false
      paramName: �\���p�����[�^��
      paramVal:  �ݒ肵�悤�Ƃ���l
      2:         �˂�2
    �߂�l:
      ini�t�@�C���ɏ����ꂽparamVal���A�����Ŏg�p����l�ɕϊ������l��Ԃ��B
    ����:
      ini�t�@�C���͗��p�҂��������̂ŁA���܂�����Ɉˑ������킩��ɂ����l��
      �v������͍̂��Ƃ������́B
      �������A���ۂ�IME��ԕ\�����ɁA�l�̕ϊ�������Ă����̂ł́A�����������B
      �����ŁA���̊֐��ŁA���炩���߁A�����ŗ��p���₷���l�ɕϊ�����paramBlock��
      �ۑ����Ă����Ă��炢�A���ۂ�IME��ԕ\�����́A���̒l���g���Ă��炤���Ƃ�
      ����B

 ...............................................................................
*/
DMS_DispParameters(val=false, param1=false, param2=false, param3=false, param4=false)
{
  static string, string_def
  static ofst_x, ofst_x_def
  static ofst_y, ofst_y_def
  static trans,  trans_def
  static grid_x,  grid_x_def
  static grid_y,  grid_y_def
  static normal,  normal_def
  static color,  color_def
  static margin_x,  margin_x_def
  static margin_y,  margin_y_def
  static fontName,  fontName_def
  static fontColor,  fontColor_def
  static fontSize,  fontSize_def
  static fontStyle,  fontStyle_def
  static frameStyle,  frameStyle_def

  static actwin
  static dsp_x, dsp_y
  
  if(val)
  {
    if(param2)
    {
      ; �l�̐ݒ�
      %val% := param1
      return
    }
    ; �l�̓ǂݏo��
    content := %val%
    return content
  }
  else
  if(param1)
  {
    ; ������Ԃ��f�t�H���g�Ƀ��Z�b�g
    string := string_def
    ofst_x := ofst_x_def
    ofst_y := ofst_y_def
    trans  := trans_def
    grid_x := grid_x_def
    grid_y := grid_y_def
    normal := normal_def
    color  := color_def
    margin_x := margin_x_def
    margin_y := margin_y_def
    fontName := fontName_def
    fontColor:= fontColor_def
    fontSize := fontSize_def
    fontStyle:= fontStyle_def
    frameStyle:= frameStyle_def

    actwin := param1
    dsp_x  := param2
    dsp_y  := param3
    return
  }
  else
  if(param2)
  {
    if(param4 == 1)
    {
      ; �p�����[�^�̐ݒ�l�m�F
      if(param2 == "trans" && (param3 < 0 || param3 > 255))
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0-255�ł��B"
      else
      if(param2 == "grid_x" && (param3 < 0))
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0�ȏ�ł��B"
      else
      if(param2 == "grid_y" && (param3 < 0))
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0�ȏ�ł��B"
      else
      if(param2 == "normal" && (param3 != 0 && param3 != 1))
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0��1�ł��B"
      else
      if((param2 == "color" || param2 == "fontColor") && param3 != "")
      {
        ; ,(�J���})���܂ނ��̂ł�������A�X�̒l���A0�`255���ǂ����`�F�b�N
        IfInString, param3, `,
        {
          count := 0
          Loop, parse, param3, `, ,%A_Space%`t
          {
            If A_LoopField is not integer
              return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́AR,G,B�̃t�H�[�}�b�g�ŁA0-255��10�i���ł��B"
            if(A_LoopField < 0 || A_LoopField > 255)
              return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́AR,G,B�̃t�H�[�}�b�g�ŁA0-255��10�i���ł��B"
            count++
          }
          if(count != 3)
            return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́AR,G,B�̃t�H�[�}�b�g�ŁA0-255��10�i���ł��B"
        }
        else
        if(StrLen(param3) != 6)
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́ARRGGBB�̃t�H�[�}�b�g��16�i��6�����ł��B"
        else
        {
          tmp = 0x%param3%
          If tmp is not integer
            return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́ARRGGBB�̃t�H�[�}�b�g��16�i��6�����ł��B"
        }
      }
      else
      if((param2 == "margin_x" || param2 == "margin_y") && param3 < 0)
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0�ȏ�ł��B"
      if(param2 == "fontSize" && param3 != "" && param3 <= 0)
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A1�ȏ�ł��B"
      else
      if(param2 == "fontStyle")
      {
        check := "`fBold`fItalic`fStrike`fUnderline`f"
        Loop, parse, param3, `, ,%A_Space%`t
        {
          IfNotInString, check, `f%A_LoopField%`f
            return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́ABold,Italic,Strike,Underline�̂����ꂩ�̒P����A�J���}�ŕ��ׂ�������ł��B"
        }
      }
      else
      if(param2 == "frameStyle" && (param3 <0 || param3 > 3))
      {
          return "�\���p�����[�^[" . param2 . "]�́A[" . param3 . "]�Ƃ����l�͐ݒ�ł��܂���B�ݒ�ł���l�́A0-3�̐����ł��B"
      }

      return ""
    }
    else
    if(param4 == 2)
    {
      ; �����g�p�̒l�ɕϊ�
      if((param2 == "color" || param2 == "fontColor") && param3 != "")
      {
        ; ,(�J���})���܂ނ��̂ł�������A16�i���̒l�ɕϊ�����
        IfInString, param3, `,
        {
          StringSplit, tmp, param3, `,, %A_Space%`t
          SetFormat, INTEGER, H
          ; RGB��24bit16�i���ɁB
          ; �ŏ�ʌ��̓_�~�[�BAHK��SetFormat�͌������낦�Ă���Ȃ�����B
          param3 := 1 * 0x1000000 + tmp1 * 0x10000 + tmp2 * 0x100 + tmp3
          SetFormat, INTEGER, D
          ; �ŏ�ʌ����܂߂�Trim
          StringTrimLeft, param3, param3, 3
        }
      }
      else
      if(param2 == "fontStyle")
      {
        ; ,(�J���})�𔼊p�X�y�[�X�ɕϊ�
        StringReplace, param3, param3, `,, %A_Space%, All
      }
      else
      if(param2 == "frameStyle")
      {
        ; 0,1,2,3���A�Ή�����Gui�I�v�V�����ɕϊ�����
        code := "-Caption,-Caption +0x00800000,-Border,-Border +E0x00000200"
        param3++
        Loop, parse, code, `,
        {
          if(param3 == A_Index)
          {
            param3 := A_LoopField
            break
          }
        }
      }
      
      return param3
    }

    ; �p�����[�^���̃T�|�[�g�m�F
    check := ";string;ofst_x;ofst_y;trans;grid_x;grid_y;normal;color;margin_x;margin_y;fontName;fontColor;fontSize;fontStyle;frameStyle;"
    IfInString, check, `;%param2%`;
      return true
    else
      return false
  }
  else
  {
    ; �f�t�H���g�l�ݒ�
    ; DMS_Default()�Ƀf�t�H���g�l�����邩�ǂ��������A�Ȃ�������A�����ŁA
    ; �f�t�H���g�ln��ݒ肷��B
    ; ���R�Ȃ���ADMS_Default()�Őݒ肳�ꂽ�l�̕����D�悳���B
    
    string_def := DMS_Default("string")
    if(string_def == "")
      string_def := ""
      
    ofst_x_def := DMS_Default("ofst_x")
    if(ofst_x_def == "")
      ofst_x_def := -18
      
    ofst_y_def := DMS_Default("ofst_y")
    if(ofst_y_def == "")
      ofst_y_def := -17
      
    trans_def := DMS_Default("trans")
    if(trans_def == "")
      trans_def := 0
      
    grid_x_def := DMS_Default("grid_x")
    if(grid_x_def == "")
      grid_x_def := 0

    grid_y_def := DMS_Default("grid_y")
    if(grid_y_def == "")
      grid_y_def := 0

    normal_def := DMS_Default("normal")
    if(normal_def == "")
      normal_def := 0

    color_def  := DMS_Default("color")
    if(color_def == "")
      color_def := ""

    margin_x_def := DMS_Default("margin_x")
    if(margin_x_def == "")
      margin_x_def := 2

    margin_y_def := DMS_Default("margin_y")
    if(margin_y_def == "")
      margin_y_def := 1

    fontName_def := DMS_Default("fontName")
    if(fontName_def == "")
      fontName_def := ""

    fontColor_def:= DMS_Default("fontColor")
    if(fontColor_def == "")
      fontColor_def := ""

    fontSize_def := DMS_Default("fontSize")
    if(fontSize_def == "")
      fontSize_def := ""

    fontStyle_def := DMS_Default("fontStyle")
    if(fontStyle_def == "")
      fontStyle_def := ""

    frameStyle_def := DMS_Default("frameStyle")
    if(frameStyle_def == "")
      frameStyle_def := "-Caption +0x00800000"

    return
  }
}

