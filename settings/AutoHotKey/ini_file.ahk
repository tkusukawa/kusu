/* 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ini_file.ahk
   ini�t�@�C�����������߂̔ėp�֐�
   ini�t�@�C���́AWindows�ŗp������A�ÓT�I�ȁA�ȉ��̂悤�Ȍ`���ł���B
   
   [�Z�N�V�������P]
   �G���g��1 = �l1
   �G���g��2 = �l2

   [�Z�N�V�������Q]
   �G���g��3 = �l3
   �G���g��4 = �l4

   �Z�N�V��������e�G���g���́A�K�����s�ŏI������K�v������B
   �s���̋󔒂͏�������̂ŁA���������Ă����܂�Ȃ��B
   ;(�Z�~�R����)�ȍ~�̓R�����g�Ƃ��āA���������B
   �����A;(�Z�~�R����)���g������������A';(�V���O���N�I�[�g�Z�~�R����)��
   �L�q����B
   
   �{���W���[���ň���ini�t�@�C���œ��{����g���ꍇ�́AShift-JIS���AEUC�ł���
   �K�v������B
   

   ver0.11.00   05/12/9
   �Ȃ܂�

 �����̃v���O�����͂Ȃ܂��̒��앨�ł����A��������ς͎��R�ɍs���Ă���������
   ���\�ł��B�܂��A�ĔЕz(���O���M)�⏤�Ɨ��p���܂ޏ��n���A�u�Ȃ܂��v�̖��O�ƁA
   URL(http://www.tierra.ne.jp/~aki/diary/)��Y���Ă���������΁A�����R��
   ���Ă��������Č��\�ł��B���ς������̂��ĔЕz(���O���M)����n����ꍇ�́A
   ���ς����|��\�L���Ă��������B
 �����̃v���O�����𗘗p���Đ����������Ȃ鑹�Q�ɑ΂��Ă��A�Ȃ܂��͐ӔC�𕉂���
   ����B�������炸���������������B
   
 �ύX����

   ver0.11.00   05/12/9
   ini�t�@�C���������ݗp�ɁAINI_WriteIniFile()���쐬�B
   ���ƁAINI_AddIni()�ɁA�R�����g���������߂�悤�ɂ����B

   ver0.10.00   05/11/30
   �ŏ��̃o�[�W����



 �ړ���
   INI_
   �{�t�@�C���Œ�`���ꂽ�O���[�o����(�֐�)�́A���ׂ�
   "INI_"�Ƃ����ړ�������B
   
 �O���[�o���ϐ�
   ��؃O���[�o���ϐ��͎g���Ă��Ȃ��B
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

/*
 ...............................................................

  ini�t�@�C����ǂݏo��
  
  INI_ReadIniFile(ini_file, ByRef raw_ini, ByRef message, 
                                       checkDupSection, checkDupEntry)
    ����:   
      ini_file        : ini�t�@�C���̃t�@�C����
      raw_ini         : ini_file�̑S���e����̕�����ŕ\���������̂��i�[�����
      message         : ini_file�ɃG���[���������ꍇ�A�G���[���b�Z�[�W������
      checkDupSection : true�Ȃ�A�Z�N�V�������̏d�����`�F�b�N����B
                        false�Ȃ�`�F�b�N���Ȃ��B
                        �ȗ������ꍇ�́Atrue
      checkDupEntry   : true�Ȃ�A����Z�N�V�������̃G���g���[���̏d�����`�F�b�N
                        false�Ȃ�`�F�b�N���Ȃ��B
                        �ȗ������ꍇ�́Atrue
    �߂�l: 
      ini_file���G���[���܂ނ���(�Z�N�V�������G���g���̏d����`)��������Afalse
      �G���[���Ȃ�������Atrue��Ԃ�
    ����:
      �t�@�C���擪����Ō�܂ň�s���ǂݍ��݁A
      1)�R�����g�̍폜
      2)�Z�N�V���������ǂ������f�A�Z�N�V��������ǂݏo���A�ۑ�
      3)�G���g�����ǂ������f�A�G���g�����ƒl��ǂݏo���A�ۑ�

      raw_ini�́A�ȉ��̃t�H�[�}�b�g������
      
      raw_ini := section `n section `n section `n...
      
        section := section�� `v entry `a entry `a ...
        
          entry := entry�� `b �l


���_�������΍�ɂ���
  AutoHotkey�͉p�ꌗ�̃\�t�g�Ȃ̂ŁA���{��Ɖp�ꂪ���݂������ŕ�����T�[�`��
  ���܂��ƁA�_��������肪��������\��������B�܂�A�p����T�[�`�����̂ɁA
  ���{���1byte�������|���Ă��܂��A2byte�̓��{�ꂪ�����ʂ�A�ƌ����z�ł���B

  EUC�́A�K��0x80�ȏ�Ȃ̂ŁA��L�̖��͔������Ȃ��B
  Shift-JIS�̏ꍇ�A2byte�ڂ��A0x40�ȏ�̒l���g���Ă���̂ŁA��L��肪��������B
  
  �{�֐��ŃT�[�`����̂́A";"�ƁA"="�ƁA"'"�ƁA"["�ł���B
  ���̂����A";","=","'"�́A0x3f�ȉ��̒l�Ȃ̂ŁAShift-JIS�ł͎g���Ȃ��B
  "["�́AShift-JIS�Ŏg����\��������̂ŁA������̐擪��"["�ł��邩�ǂ���
  ���f���邾���ɂƂǂ߁A�T�[�`���s��Ȃ����ƂŁA�_������������������B

  �܂��A����͏�L�Ή��łȂ�Ƃ��Ȃ������A���������C�ɂ���̂��A�������A
  �Ȃ񂩍l�������ł��ˁB
 ...............................................................
*/  
INI_ReadIniFile(ini_file, ByRef raw_ini, ByRef message, checkDupSection = true, checkDupEntry = true)
{
  section := ""
  raw_ini := ""
  Loop, READ, %ini_file%
  {
    if(A_LoopReadLine == "")
      continue

    ; ';���A��������`f�ɕϊ����Ă���
    StringReplace, com_line, A_LoopReadLine, `'`;, `f, All
  
    ; �R�����g";"�ȉ���S����
    StringSplit, tmp, com_line, `;, %A_Space%`t
    if(tmp1 == "")
    {
      continue
    }

    ; `f�ɑޔ����Ă�����';���A;�ɕ��A����
    StringReplace, line, tmp1, `f, `;, All

    ; []�ň͂܂ꂽ�Z�N�V�����������o��
    ; �_�������΍�̂��߁A�擪�̈ꕶ����[��������Z�N�V�����Ƃ��A
    ; �Ō��1������]���ǂ����͂킩��Ȃ����Atrim���邱�ƂőΏ�����B
    StringGetPos, kakkoPos, line, [
    if(kakkoPos == 0)
    {
      ; �ŏ��ƍŌ��1������trim����B
      StringTrimLeft, line, line, 1
      StringTrimRight, line, line, 1

      ; section������������
      raw_ini := raw_ini . "`n" . line . "`v"
      section := line

      continue
    }
    
    ; �G���g���̎��o���B�ŏ��ɏo�Ă���"="�����o����B
    StringGetPos, eqPos, line, `=
    if(ErrorLevel)
    {
      ; "="��������Ȃ�������A��������
      continue
    }
      
    StringLeft, entryName, line, %eqPos%
    if(entryName != "")
    {
      StringSplit, tmp, entryName, `f, %A_Space%`t  ; �󔒂̏���
      entryName := tmp1
    }

    if(entryName == "")
    {
      ; �G���g���̖��O��NULL�Ȃ疳������
      ; �s����"="����������悤�ȏꍇ
      continue
    }

    eqPos++
    StringTrimLeft, entryVal, line, %eqPos%
    
    if(entryVal != "")
    {
      StringSplit, tmp, entryVal, `f, %A_Space%`t  ; �󔒂̏���
      entryVal := tmp1
    }
    
    ;����ŁA�G���g��������ꂽ�B�S�̂ƌ�������B
    if(section != "")
    {
      raw_ini := raw_ini . entryName . "`b" . entryVal . "`a"
    }
  }

  ; ���d��`�̌��o
  section_history := "`f"
  Loop, parse, raw_ini, `n
  {
    ; �Z�N�V�������Ƃ̃��[�v

    if(!A_LoopField)
      Continue
    
    StringSplit, tmp, A_LoopField, `v
    section := tmp1
    entries := tmp2

    ; �Z�N�V�������̑��d��`�̌��o
    if(checkDupSection)
    {
      IfInString, section_history, `f%section%`f
      {
        message = �Z�N�V����[%section%]���A���d�ݒ肳��Ă��܂��B
        return false
      }
      section_history := section_history . section . "`f"
    }

    entry_history := "`f"
    ; �Z�N�V�������̃G���g���̑��d��`�̌��o
    Loop, parse, entries, `a
    {
      if(!A_LoopField)
        Continue

      StringSplit, tmp, A_LoopField, `b
      entryName := tmp1

      if(checkDupEntry)
      {
        IfInString, entry_history, `f%entryName%`f
        {
          message := "�Z�N�V����[" . section . "]�̒��̃G���g���[[" . entryName . "]���A���d�ݒ肳��Ă��܂��B"
          return false
        }
        entry_history := entry_history . entryName . "`f"
      }
    }
  }
  return true
}

/*
 ...............................................................

  ini�t�@�C��������̃G���g�������o��
  
  INI_ParseIni(ByRef parse_ini, ByRef section, ByRef entryName, ByRef entryVal)
    ����:   
      parse_ini       : ini�t�@�C����1�̕�����ɂ܂Ƃ߂����́BINI_ReadIniFile��
                        �o�́B�{�֐��łP�G���g�����o������A���̕��Aparse_ini��
                        �Z���Ȃ�B
      section         : �Z�N�V������
      entryName       : �G���g����
      entryVal        : �G���g���̒l
    �߂�l: 
      parse_ini��NULL(���ׂẴG���g����ǂݏI����)�Ȃ�false�B
      �G���g���l�����o������true
    ����:
      parse_ini�́A�G���g�������o�����ƂɒZ���Ȃ�B������A
      ����parse_ini���w�肵�āA���x��INI_ParseIni���Ăׂ΁Aini�t�@�C����
      �G���g�������ԂɎ��o�����Ƃ��ł���B
      �Z�N�V�������݂̂ŁA�G���g�����Ȃ��Z�N�V�����́AentryName��NULL��
      ����B�ŏ��̓G���g�����������Z�N�V�������A���̃Z�N�V������ǂݏo����
      ���܂��ƁA�G���g���̂Ȃ��Z�N�V�����ɂȂ�B
      �Ⴆ�΁A�ȉ��̂悤�ȃZ�N�V�������������Ƃ���B

      [�T���v��1]
      �G���g��1 = a

      ���̃Z�N�V������ǂݏo���ƁA

        section =   �T���v��1
        entryName = �G���g��1
        entryVal  = a

      �Ƃ����l��������B�����āAparse_ini�́A

      [�T���v��1]

      �ƂȂ�B���������ǂݏo���ƁA

        section =   �T���v��1
        entryName = ""
        entryVal  = ""

      �ƂȂ�B
      ����𗘗p���āAentryName��NULL�Ȃ̂����o���āA�Z�N�V�����̍Ō��
      �Ȃɂ����������s���邱�Ƃ��ł���B�G���g���̌��͓ǂݏo���Ă݂Ȃ����
      �킩��Ȃ��B������A�u����ł��̃Z�N�V�����͂����܂��v�Ƃ����^�C�~���O��
      �ǂ����Ă��~�����Ƃ���B������AentryName��NULL�Ȃ̂����o���邱�ƂŁA
      �������邱�Ƃ��ł���B
 ...............................................................
*/  
INI_ParseIni(ByRef parse_ini, ByRef section, ByRef entryName, ByRef entryVal)
{

  find := false
  entryName := ""
  entryVal  := ""

  ; parse_ini�́A��ŁA�ǂݏo�����G���g������؂����āA�Z������B
  ; ���̂Ƃ��A��؂�L��`n��`a�������āA�؂���ʒu�����o����̂����A
  ; ���̍ہA���ڂ�`n��`a�Ő؂��邩���A�ȉ��̃J�E���^�ŔF������B
  ; `n��`a�́A�����̗���ɂ���ẮA�璷�ɖ��ߍ��܂�Ă��邱�Ƃ�����B
  ; ����́AA_LoopField��NULL���ǂ����œǂݔ�΂��̂����A���̍ہA�ǂݔ�΂���
  ; �񐔂��ȉ��̃J�E���^�Ŋo���Ă����A����ŁA�؂���ʒu���ԈႢ�̂Ȃ����̂�
  ; ����킯�B
  n_count := 0
  a_count := 0

  Loop, parse, parse_ini, `n
  {
    ; �Z�N�V�������Ƃ̃��[�v
  
    n_count++

    if(!A_LoopField)
      Continue

    ;�Z�N�V�������ƕ����̃G���g���Ƃ𕪗�
    StringSplit, tmp, A_LoopField, `v
    section := tmp1
    entries := tmp2

    Loop, parse, entries, `a
    {
      ; �G���g�����Ƃ̃��[�v

      a_count++

      if(!A_LoopField)
        Continue

      ;�G���g�����ƒl�𕪗�
      StringSplit, tmp, A_LoopField, `b
      entryName := tmp1
      entryVal := tmp2
      break
    }
    find := true
    break
  }
  
  if(find)
  {
    if(entryName == "")
    {
      ; �G���g��������Ȃ������B����̃Z�N�V�����܂Ő؂���
      StringGetPos, pos, parse_ini, `n, L%n_count%
      pos++
      if(pos)
        StringTrimLeft, parse_ini, parse_ini, pos
      else
        ; ����`n���Ȃ������B�܂�A���̃t�@�C���͂����܂�
        parse_ini := ""
    }
    else
    {
      ; ���̃G���g���܂Ő؂���
      StringGetPos, pos, parse_ini, `a, L%a_count%
      pos++
      StringTrimLeft, parse_ini, parse_ini, pos
      ; ����̃Z�N�V�������͓��ɂ���
      parse_ini := section . "`v" . parse_ini
    }
    return true
  }
  else
    return false
}

/*
 ...............................................................

  ini�t�@�C����������쐬����B
  
  INI_AddIni(ByRef this_ini, section, entryName = "", entryVal = "",
                                                         comment = "")
    ����:   
      this_ini        : ini�t�@�C��������
      section         : �Z�N�V������
      entryName       : �G���g�����B�ȗ�������NULL
      entryVal        : �G���g���̒l�B�ȗ�������NULL
      comment         : �G���g���s�ɑ΂���R�����g�B�ȗ�������NULL
    �߂�l: 
      �Ȃ�
    ����:
      this_ini�ɁA�Z�N�V�������ƃG���g����ǉ�����B
      section��NULL�ɂ���ƁA�G���g�������ǉ�����B�܂�A���ł�
      �Z�N�V��������this_ini�ɒǉ����Ă��āA�G���g�������ǉ�������
      ���́Asection��NULL�ɂ���Bsection��NULL����Ȃ��ƁA�V����
      �Z�N�V�����Ƃ��Ēǉ����Ă��܂��̂ŁA���ӁB
      �R�����g�́AINI_ParseIni()�ł͓ǂݔ�΂���邪�AINI_WriteIniFile�ł́A
      �t�@�C���ɏ������܂��B
 ...............................................................
*/  
INI_AddIni(ByRef this_ini, section, entryName = "", entryVal = "", comment = "")
{
  if(section != "")
    this_ini := this_ini . "`n" . section . "`v"
    
  if(entryName != "")
    this_ini := this_ini . entryName . "`b" . entryVal

  if(comment != "")
    this_ini := this_ini . "`b" . comment . "`a"
  else
    this_ini := this_ini . "`a"
    
}

/*
 ...............................................................

  ini�t�@�C�����쐬����
  
  INI_WriteIniFile(ini_file, raw_ini, ByRef message,comment = "")

    ����:   
      ini_file        : ini�t�@�C���̃t�@�C����
      raw_ini         : ini_file�̑S���e����̕�����ŕ\���������́B
                      ; INI_AddIni()�̏o��
      message         : �������݁A���邢�̓t�@�C���̍폜�ɃG���[���������ꍇ�A
                      ; �G���[���b�Z�[�W������
      comment         ; �t�@�C���̐擪�ɏ������ރR�����g�B�ȗ����͂Ȃ�

    �߂�l: 
      �t�@�C���쐬�����Ȃ�true�A���s��false���Ԃ�
    ����:
      1)ini_file�����݂���Ȃ�A����
      2)raw_ini���p�[�X���āAini_file�ɏ�������

 ...............................................................
*/  
INI_WriteIniFile(ini_file, raw_ini, ByRef message,comment = "")
{
  IfExist, %ini_file%
  {
    FileDelete, %ini_file%
    if(ErrorLevel)
    {
      message = [%ini_file%]�̍폜�Ɏ��s���܂���
      return false
    }
  }

  err_mes = [%ini_file%]�̏������݂Ɏ��s���܂���

  ; �t�@�C���̐擪�̃R�����g�̓���
  if(comment != "")
  {
     FileAppend , `; %comment%`n, %ini_file%
    if(ErrorLevel)
    {
      message = err_mes
      return false
    }
  }
  
  Loop, parse, raw_ini, `n
  {
    ; �Z�N�V�������Ƃ̃��[�v

    if(!A_LoopField)
      Continue

    ;�Z�N�V�������ƕ����̃G���g���Ƃ𕪗�
    StringSplit, tmp, A_LoopField, `v
    section := tmp1
    entries := tmp2

    ; �Z�N�V�������̏�������
    FileAppend , [%section%]`n, %ini_file%
    if(ErrorLevel)
    {
      message = err_mes
      return false
    }

    Loop, parse, entries, `a
    {
      ; �G���g�����Ƃ̃��[�v

      if(!A_LoopField)
        Continue

      ;�G���g�����ƒl�𕪗�
      tmp3 := ""
      StringSplit, tmp, A_LoopField, `b
      entryName := tmp1
      entryVal := tmp2
      comment := tmp3

      FileAppend , %entryName% = %entryVal% , %ini_file%
      if(ErrorLevel)
      {
        message = err_mes
        return false
      }
      
      if(tmp3 != "")
      {
        FileAppend , %A_Space%`; %comment%, %ini_file%
        if(ErrorLevel)
        {
          message = err_mes
          return false
        }
      }
      FileAppend , `n, %ini_file%
      if(ErrorLevel)
      {
        message = err_mes
        return false
      }
    }
  }

  return true
}



