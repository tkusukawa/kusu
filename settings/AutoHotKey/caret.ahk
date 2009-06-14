/* 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 caret.ahk
   �L�����b�g���������߂̔ėp�֐�

   ver0.11.01   05/12/16
   �Ȃ܂�

 �����̃v���O�����͂Ȃ܂��̒��앨�ł����A��������ς͎��R�ɍs���Ă���������
   ���\�ł��B�܂��A�ĔЕz(���O���M)�⏤�Ɨ��p���܂ޏ��n���A�u�Ȃ܂��v�̖��O�ƁA
   URL(http://www.tierra.ne.jp/~aki/diary/)��Y���Ă���������΁A�����R��
   ���Ă��������Č��\�ł��B���ς������̂��ĔЕz(���O���M)����n����ꍇ�́A
   ���ς����|��\�L���Ă��������B
 �����̃v���O�����𗘗p���Đ����������Ȃ鑹�Q�ɑ΂��Ă��A�Ȃ܂��͐ӔC�𕉂���
   ����B�������炸���������������B

 �ύX����
 
 ver0.11.01   05/12/16
   �R���g���[�����[�J�����W�̎��o���Ƀo�O���������̂��C��
   �}���`�X���b�h�Z�[�t�ɂȂ�悤�ɁAstatic�ϐ��̈����̒���
   �G�X�P�[�v�L��(�o�b�N�N�I�[�g)��p�~

 ver0.11.00   05/12/5
   ���샂�[�h�w���API�̒ǉ�
   �O��̃E�C���h�E�̃��Z�b�g��API�̒ǉ�

 ver0.10.00   05/11/30
   �ŏ��̃o�[�W����

   
 �ړ���
   CAR_
   �{�t�@�C���Œ�`���ꂽ�O���[�o����(�֐�)�́A���ׂ�
   "CAR_"�Ƃ����ړ�������B
   
 �O���[�o���ϐ�
   ��؃O���[�o���ϐ��͎g���Ă��Ȃ��B
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

/*
 ...............................................................

  �L�����b�g���W��ǂݏo��

  actwin�Ŏw�肳�ꂽ�E�C���h�E�̃L�����b�g���W�̓ǂݏo��
  CAR_GetCaretPos(actwin, ByRef car_x, ByRef car_y, alwaysCaretOn = false)
    ����:   
      actwin          : �E�C���h�EID
      car_x           : �L�����b�gx���W(�X�N���[���n)���i�[�����
      car_y           : �L�����b�gy���W(�X�N���[���n)���i�[�����
      alwaysCaretOn   : �{�A�v���́A���o�����L�����b�g�̍��W��(0,0)�̏ꍇ�́A
                        �L�����b�g���\������Ă��Ȃ��A�Ɣ��f����B���W(0,0)���ƁA
                        �L�����b�g���e�L�X�g�{�b�N�X�Ȃǂɒ���t���Ă��܂��̂ŁA
                        ���́A�L�����b�g�́A(0,0)�ȊO�̍��W�l�����B�������A
                        �����܂�ɁA�L�����b�g���o�Ă���̂ɁA(0,0)�̍��W�l��
                        �����Ă��܂��A�v�������݂���B���̏ꍇ�A�L�����b�g������
                        �Ɋ񂹂��Ƃ������AIME�\�����o�Ȃ��Ȃ�Ƃ������ʂɂȂ�B
                        ���̂悤�ȏꍇ�ɁA���̃p�����[�^�ŁA�R���g���[���̖��O
                        (ClassNN)�Ɋ܂܂�镶������w�肷��B����ƁA�����Ŏw�肵
                        ����������܂ރR���g���[���Ƀt�H�[�J�X������ꍇ�́A
                        �L�����b�g�̍��W�Ɋւ�炸�A�L�����b�g���o�Ă����
                        ���f����B","�ŋ�؂��āA�����w�肷�邱�Ƃ��ł���B
                        �ȗ����́ANULL
    �߂�l: 
      �L�����b�g���o�Ă����true�A�����łȂ����false
    ����:
      DllCall�ŁAGetCaretPos���Ăяo�����Ƃɂ���āA�L�����b�g���W�𓾂�B
    ���m�̖��:
      �E�ȉ��́u���샂�[�h�̎w��v�ŁAalwaysAttach��true�ɂ��Ȃ��ꍇ�́A
        �_�u���N���b�N�Ƃ��̊֐��̃R�[�����d�Ȃ�ƁA�_�u���N���b�N�����o�ł��Ȃ�
        �Ȃ�B�܂��A�^�C�}�ō��p�x�Ŗ{�֐����ĂԂƁAIE�̉摜�ɃJ�[�\����u����
        ���̃c�[���`�b�v���o�Ȃ��Ȃ铙�̕���p���o��B
      �E�ȉ��́u���샂�[�h�̎w��v�ŁAalwaysAttach��true�ɂ����ꍇ�́A
        �{�֐����Ăяo���X�N���v�g��Send�R�}���h���g�p����ƁA���e�����o��Ƃ���
        ����p������B
      �E�A�v���ɂ���ẮA�L�����b�g���o�Ă��Ȃ��̂ɁA�L�����b�g���o�Ă����
        ���f����Ă��܂����Ƃ�����(�Ⴆ�΁ASleipnir�ŁAWeb�̃t�H�[���ŃJ�[�\��
        ���o�������ƁA�G�N�X�v���[���o�[�Ƀt�H�[�J�X�������Ă����ƁA�L�����b�g��
        �Ȃ��̂ɁA�L�����b�g���W���o�邱�Ƃ�����)�B
        ����A���̖��͉����ł��ĂȂ��B(���R�AA_CaretX���g���Ă��A���̖���
        ��������)
    �}���`�X���b�h�Ή�:
      �{�֐��̓}���`�X���b�h�Z�[�t�ł���B
      �����̃X���b�h���瓯���ɃR�[�����Ă����Ȃ����삷��B

  �R���g���[�����W�n�̃L�����b�g���W�̎��o��
  CAR_GetCaretPos(false, ByRef car_x, ByRef car_y)
    ����:   
      false           : ���false
      car_x           : �L�����b�gx���W(�R���g���[���n)���i�[�����
      car_y           : �L�����b�gy���W(�R���g���[���n)���i�[�����
    �߂�l: 
      �R���g���[���̃E�C���h�EID���Ԃ�
    ����:
      �O��A�uactwin�Ŏw�肳�ꂽ�E�C���h�E�̃L�����b�g���W�̓ǂݏo���v��
      ��������(true�ŋA����)��̂݁A�{�֐����R�[������B����ȊO�̃R�[���̎��́A
      ����͕ۏႵ�Ȃ��B
      �uactwin�Ŏw�肳�ꂽ�E�C���h�E�̃L�����b�g���W�̓ǂݏo���v�́A���
      �X�N���[�����W�n�̃L�����b�g���W���Ԃ�̂ŁA�R���g���[�����W�n�ł�
      �ǂ��Ȃ��Ă�A�Ƃ����̂���Œm�肽���Ȃ����Ƃ��ɃR�[������B
    �}���`�X���b�h�Ή�:
      �I�I�I�{�֐��̓}���`�X���b�h�Z�[�t�ł͂Ȃ��I�I�I
      �P��X���b�h�݂̂Ŏg�p���邱��

  ���샂�[�h�̎w��
  CAR_GetCaretPos(false, false, false, alwaysAttach)
    ����:   
      false           : ���false
      false           : ���false
      false           : ���false
      alwaysAttach    : true�Ȃ�A��ɁA���̃A�v���̓��͏�Ԃ����L���Ă���B
                        false�Ȃ�A���W�擾�̃R�[���̓x�ɁA���͏�Ԃ̋��L��
                        �������J��Ԃ��B

    �߂�l: 
      �Ȃ�
    ����:
      �{�֐��́A���̃A�v���̃J�[�\�����W���擾���邽�߁A
      win32 API��AttachThreadInput���ĂԁB���̌Ăяo���́A���p����ƁA
      �_�u���N���b�N�����o�ł��Ȃ��Ȃ�����AIE�ŁA�摜�Ƀ}�E�X�J�[�\����
      �����čs�����Ƃ��ɁA�c�[���`�b�v���o�͂���Ȃ��Ȃ�����A�Ƃ�����
      ����p���N����B
      �����̕���p��h���ɂ́A�A�N�e�B�u�E�C���h�E�̐ؑ֎��Ɍ���A
      AttachThreadInput���Ăׂ΂悢�B�܂�A��ɑ��̃A�v���̓��͏�Ԃ�
      ���L��������Ƃ�����ԂɂȂ�B
      �������A���̏ꍇ�A���̊֐������삵�Ă���X�N���v�g���ASend�R�}���h
      �𔭍s����ƁA���̓���Ɉ��e�����o��ꍇ������B
      �����ŁAalwaysAttach��true�ɂ����Ƃ��́A��ɋ��L��Ԃɂ��A
      false�ɂ����Ƃ��́A�R�[���̓x�ɋ��L�Ƃ��̉������J��Ԃ��悤�ɂ���B
      �O�҂́A�X�N���v�g�̂ق��̕�����Send�R�}���h�Ȃǂ��g��Ȃ��ꍇ�ɁA
      ��҂́A���̃X�N���v�g(autohotkey.ini�Ȃ�)�ɑg�ݍ���Ŏg���ꍇ�ɁA
      �p����Ƃ悢�B
    �}���`�X���b�h�Ή�:
      �{�֐��̓}���`�X���b�h�Z�[�t�ł���B
      �����̃X���b�h���瓯���ɃR�[�����Ă����Ȃ����삷��B


  �O��̃E�C���h�E�̃��Z�b�g
  CAR_GetCaretPos(false, false, false, "", true)
    ����:   
      false           : ���false
      false           : ���false
      false           : ���false
      ""              : ���""
      true            : ���true
    �߂�l: 
      �Ȃ�
    ����:
      �����ŕێ����Ă���A�O��̃E�C���h�EID����������B
      ����A���W�̎擾���s���ƁA�K�����݂̓��͏�Ԃ̋��L���������āA�ēx�A
      ���L����蒼���B
      �������Ȃ��ƁA�������L�����b�g�ʒu�������Ȃ��悤�ȃA�v��(�p���|�Ƃ�)
      �ɑ΂��čs���B
    �}���`�X���b�h�Ή�:
      �{�֐��̓}���`�X���b�h�Z�[�t�ł���B
      �����̃X���b�h���瓯���ɃR�[�����Ă����Ȃ����삷��B

 ...............................................................
*/  
CAR_GetCaretPos(actwin, ByRef car_x, ByRef car_y, always = "", reset = false)
{
  static myThreadID
  static localPoint
  static last_focus_cntrl
  static alwaysAttach
  static last_actwin
  static last_threadID

  ; �X���b�h�Z�[�t�΍�
  ; ���������Ă���Œ��ɁA�ʂ̃X���b�h�Ŋ��荞�܂�āAstatic�̒l��ς�����ƁA
  ; �\�����ʃo�O�������N�����̂ŁA�����ɓ���Ȃ������ɁA������auto�ϐ���
  ; �R�s�[���Ă����B
  lastActWin := last_actwin
  lastThreadID := last_threadID
  alwysAtch := alwaysAttach

  if(!actwin)
  {
    if(always != "")
    {
      ; always��NULL�łȂ��Ƃ������Ƃ́Aalways�́AalwaysAttach�̂��Ƃł���B
      alwaysAttach := always
      return
    }

    if(reset)
      last_actwin := 0
    
    ; actwin��false�Ȃ̂ŁA�O�񓾂�ꂽ���W���R���g���[�����W�ɖ߂��A
    ; ���̍��W�l��Ԃ��B

    ; POINT�\���̂�����W�l�̎��o���B
    ; POINT�\���̂́A�{����32bit��int�̃����o�ō\������Ă���̂����A
    ; �{�֐��̓f�X�N�g�b�v�̍��W�Ɋւ���l�����o���̂ł����āA�p�\�R����
    ; �f�X�N�g�b�v�̉𑜓x��16bit int�̌��E��3���𒴂���Ƃ͓����l�����Ȃ�
    ; �̂ŁA������Ƃł��������グ�邽�߂ɁA16bit���̎��o���������Ă��Ȃ��B
    ; �����āA4K2K�̕��y�����āA����5�N�͂�����񂶂�Ȃ��ł����H3���z���Ȃ�āA
    ; ���ɂȂ邩�B����Ȗ����ɁA����ȃX�N���v�g�A�N���g��Ȃ��ł���B
    ptr := &localPoint

    car_x := *ptr | (*(ptr+1) << 8)
    if(car_x > 0x8000)
      car_x := -(0xffff - car_x + 1)

    ptr += 4
    car_y := *ptr | (*(ptr+1) << 8)
    if(car_y > 0x8000)
      car_y := -(0xffff - car_y + 1)
    
    DllCall("GetCaretPos\HookInstall", "Uint",actwin, "Str",point, "Uint")

    return last_focus_cntrl
  }

  ; �{�X�N���v�g�̃X���b�hID���܂����o���ĂȂ�������A���o��
  if(!myThreadID)
    myThreadID := DllCall("GetCurrentThreadId")

  if(actwin != lastActwin || !alwysAtch)
  {
    if(lastThreadID && alwysAtch)
    {
      DllCall("AttachThreadInput"
               , "Uint",myThreadID, "Uint",lastThreadID,"Uint",0)
    }
  
    ; �ΏۃE�C���h�E�̃X���b�hID�����o���āA�{�X���b�h�Ɠ��͏�Ԃ����L����B
    actwinThreadID := DllCall("GetWindowThreadProcessId"
                               , "Uint",actwin, "Uint",0)
    DllCall("AttachThreadInput"
             , "Uint",myThreadID, "Uint",actwinThreadID,"Uint",1)
    last_actwin := actwin
    last_threadID := actwinThreadID
  }

  ; �t�H�[�J�X������R���g���[����ID�����o��
  focus_cntrl := DllCall("GetFocus")
  last_focus_cntrl := focus_cntrl
  if(!focus_cntrl)
  {
    ; �t�H�[�J�X���Ȃ�������A���͏�ԋ��L������߁A���^�[��
    if(!alwysAtch)
    {
      DllCall("AttachThreadInput"
              , "Uint",myThreadID, "Uint",actwinThreadID,"Uint",0)
    }
    return false
  }

  ; �L�����b�g���W���o��
  VarSetCapacity(point,8)
;  result := DllCall("GetCaretPos", "Str",point, "Uint")
  result := DllCall("GetCaretPos\fnGetCaretPos", "Uint",actwin, "Str",point, "Uint")

  ; ���͏�ԋ��L�������
  ; ���������Ă����Ȃ��ƁA���̃X�N���v�g�̂ق��̂Ƃ���ł�Send�R�}���h��
  ; ���e�����o��B
  if(!alwysAtch)
  {
    DllCall("AttachThreadInput"
             , "Uint",myThreadID, "Uint",actwinThreadID,"Uint",0)
  }

  ; �L�����b�g���W���o�������s������A���^�[���B(����A�@�\���Ă�̂��ȁH)
  if(!result)
    return false

  ptr := &point
  
  if(!(*ptr) && !(*(ptr+1)) && !(*(ptr+4)) && !(*(ptr+5)))
  {
    ; ���W��(0,0)������
  
    if(!always)
      return false
    
    ; alwaysCaretOn�ɒl���w�肳��Ă����̂ŁA���̃A�N�e�B�u�R���g���[����
    ; �N���X�����A�����Ŏw�肳�ꂽ��������܂ނ����ׂāA
    ; ��������Ȃ�������Afalse�Ń��^�[��
    WinGetClass, cntrlClass, ahk_id %focus_cntrl%
    found := false
    dlmt := ","
    Loop, parse, always, %dlmt%
    {
      IfInString, cntrlClass, %A_LoopField%
      {
        found := true
        break
      }
    }
    if(!found)
      return false
  }

  ; �R���g���[�����[�J�����W��ޔ�
  VarSetCapacity(localPoint,8)
  DllCall("RtlMoveMemory", "Str",localPoint, "Str",point,"Uint",8)

  ; �X�N���[�����W�ɕϊ�
  DllCall("ClientToScreen","Uint",focus_cntrl,"Str",point)

  ; �\���̂�����W�l�̎��o��
  ; 16bit���������o���ĂȂ�(��L�Q��)
  car_x := *ptr | (*(ptr+1) << 8)
  if(car_x > 0x8000)
    car_x := -(0xffff - car_x + 1)

  ptr += 4
  car_y := *ptr | (*(ptr+1) << 8)
  if(car_y > 0x8000)
    car_y := -(0xffff - car_y + 1)

;  MsgBox, 16,%car_x%, %car_y%

  return true
}
