@ECHO OFF
CHCP 1252
TITLE LiSTMAKER
CLS

TREE /a "B:\" > "D:\LiSTE_BACKUP.txt"

pause

TREE /f /a "B:\" > "D:\LiSTE_BACKUP_DATEiEN.txt"

EXIT