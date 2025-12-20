Imports System.IO
Imports System.Globalization
Imports System.Text

Public Class MainForm
    Private Enum Language As Integer
        English = 0
        German = 1
    End Enum

    Private Declare Unicode Function GetPrivateProfileSectionNamesW Lib "kernel32" (ByVal Value As String, ByVal Length As Integer, ByVal Filename As String) As Integer
    Private Declare Unicode Function GetPrivateProfileStringW Lib "kernel32" (ByVal Section As String, ByVal Key As String, ByVal DefaultValue As String, ByVal Value As String, ByVal Length As Integer, ByVal Filename As String) As Integer

    Private Const BufferSize As Integer = 16384

    Private Sub uxBrowse_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles uxBrowse.Click
        Dim TemporaryFilename As String = System.Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) & "\mtaconv" & System.DateTime.Now.ToBinary

        If uxOpenFile.ShowDialog <> Windows.Forms.DialogResult.Cancel AndAlso File.Exists(uxOpenFile.FileName) Then
            uxFile.Text = uxOpenFile.FileName
            Try
                File.WriteAllText(TemporaryFilename, File.ReadAllText(uxOpenFile.FileName))
                uxBBCode.Text = Convert(TemporaryFilename, uxOpenFile.SafeFileName.Substring(0, uxOpenFile.SafeFileName.LastIndexOf(".")), uxLanguage.SelectedIndex)
                File.Delete(TemporaryFilename)
            Catch ex As Exception
                uxBBCode.Text = ""
            End Try
        End If
    End Sub

    Private Function Convert(ByVal Filename As String, ByVal Title As String, ByVal Language As Language) As String
        Dim Actions As Integer, Counter As Integer, Length As Integer
        Dim Value As String = Space(BufferSize)

        If Filename = "" Then
            Convert = ""
            Exit Function
        End If

        Length = GetPrivateProfileSectionNamesW(Value, BufferSize, Filename)
        Actions = Value.Substring(0, Length).Split(vbNullChar).GetUpperBound(0)

        Convert = ""

        If Language = Language.German Then
            Convert &= "[i]Name der Aktionengruppe:[/i] [b]" & Title & "[/b]" & vbNewLine & vbNewLine

            For Counter = 0 To Actions - 1
                If Actions > 1 Then
                    Convert &= "Aktion #" & Counter + 1 & ":" & vbNewLine
                End If
                Convert &= "[i]Aktionstyp:[/i] "
                Select Case KeyValue(Counter, "T", Filename)
                    Case "1"
                        Convert &= "[b][color=green]Schreibweise[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Schreibweise:[/i] "
                        Select Case KeyValue(Counter, "1", Filename)
                            Case "2"
                                Convert &= "[b]GROSS[/b]" & vbNewLine
                            Case "4"
                                Convert &= "[b]klein[/b]" & vbNewLine
                            Case "8"
                                Convert &= "[b]Satzweise[/b]" & vbNewLine
                            Case Else
                                Convert &= "[b]Normal[/b]" & vbNewLine
                        End Select
                        Convert &= "[i]Wortbeginn nach:[/i] [b]" & KeyValue(Counter, "2", Filename) & "[/b]" & vbNewLine
                    Case "2"
                        Convert &= "[b][color=green]Ersetzen[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Original:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Ersetzen durch:[/i] [b]" & KeyValue(Counter, "2", Filename) & "[/b]" & vbNewLine
                        Select Case KeyValue(Counter, "3", Filename)
                            Case "1|0"
                                Convert &= "[color=darkblue][x] Nur als Wort ersetzen" & vbNewLine
                                Convert &= "[ ] Groß-/Kleinschreibung berücksichtigen[/color]" & vbNewLine
                            Case "0|1"
                                Convert &= "[color=darkblue][ ] Nur als Wort ersetzen" & vbNewLine
                                Convert &= "[x] Groß-/Kleinschreibung berücksichtigen[/color]" & vbNewLine
                            Case "1|1"
                                Convert &= "[color=darkblue][x] Nur als Wort ersetzen" & vbNewLine
                                Convert &= "[x] Groß-/Kleinschreibung berücksichtigen[/color]" & vbNewLine
                            Case Else
                                Convert &= "[color=darkblue][ ] Nur als Wort ersetzen" & vbNewLine
                                Convert &= "[ ] Groß-/Kleinschreibung berücksichtigen[/color]" & vbNewLine
                        End Select
                    Case "3"
                        Convert &= "[b][color=green]Dateinamen auf 64 Zeichen verkürzen[/color][/b]" & vbNewLine
                        Convert &= "[i]Art:[/i] "
                        If KeyValue(Counter, "1", Filename) = "2" Then
                            Convert &= "[b]intelligent[/b]" & vbNewLine
                        Else
                            Convert &= "[b]abschneiden[/b]" & vbNewLine
                        End If
                    Case "4"
                        Convert &= "[b][color=green]Ersetzen mit regulären Ausdrücken[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Regulärer Ausdruck:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Treffer ersetzen durch:[/i] [b]" & KeyValue(Counter, "2", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "3", Filename) = "1" Then
                            Convert &= "[color=darkblue][x] Groß-/Kleinschreibung berücksichtigen[/color]" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Groß-/Kleinschreibung berücksichtigen[/color]" & vbNewLine
                        End If
                    Case "5"
                        Convert &= "[b][color=green]Tag-Felder formatieren[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Formatstring:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "6"
                        Convert &= "[b][color=green]Doppelte Tag-Felder entfernen[/color][/b]" & vbNewLine
                    Case "7"
                        Convert &= "[b][color=green]Tag-Felder importieren[/color][/b]" & vbNewLine
                        Convert &= "[i]Quellformat:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Formatstring:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "8"
                        Convert &= "[b][color=green]Doppelte Tag-Felder zusammenfassen[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Trennzeichen:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "9"
                        Convert &= "[b][color=green]Tag-Felder entfernen[/color][/b]" & vbNewLine
                        Convert &= "[i]Folgende Tag-Felder entfernen (getrennt durch Semikolon ; ):[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                    Case "10"
                        Convert &= "[b][color=green]Tag-Felder entfernen außer[/color][/b]" & vbNewLine
                        Convert &= "[i]Folgende Tag-Felder nicht entfernen (getrennt durch Semikolon ; ):[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                    Case "11"
                        Convert &= "[b][color=green]Codepage konvertieren[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Codepage:[/i] [b]" & Globalization.CultureInfo.GetCultureInfo(CInt(KeyValue(Counter, "1", Filename))).EnglishName & " - " & Globalization.CultureInfo.GetCultureInfo(CInt(KeyValue(Counter, "1", Filename))).NativeName & " (" & Globalization.CultureInfo.GetCultureInfo(CInt(KeyValue(Counter, "1", Filename))).TextInfo.ANSICodePage & ")" & "[/b]" & vbNewLine
                    Case "12"
                        Convert &= "[b][color=green]Album-Cover aus Datei importieren[/color][/b]" & vbNewLine
                        Convert &= "[i]Formatstring für Cover-Dateiname:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "2", Filename) = "1" Then
                            Convert &= "[color=darkblue][x] Existierende Cover löschen[/color]" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Existierende Cover löschen[/color]" & vbNewLine
                        End If
                    Case "13"
                        Convert &= "[b][color=green]Album-Cover exportieren[/color][/b]" & vbNewLine
                        Convert &= "[i]Formatstring für Cover-Dateiname:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "2", Filename) = "1" Then
                            Convert &= "[color=darkblue][x] Duplikate exportieren[/color]" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Duplikate exportieren[/color]" & vbNewLine
                        End If
                    Case "14"
                        Convert &= "[b][color=green]Text-Datei importieren[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Dateiname:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "15"
                        Convert &= "[b][color=green]Export[/color][/b]" & vbNewLine
                        Convert &= "[i]Exportdatei auswählen:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Dateiname der Exportdatei:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "2", Filename) Then
                            Convert &= "[color=darkblue][x] Daten anhängen" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Daten anhängen" & vbNewLine
                        End If
                        If KeyValue(Counter, "3", Filename) Then
                            Convert &= "[x] Eine Datei pro Verzeichnis[/color]" & vbNewLine
                        Else
                            Convert &= "[ ] Eine Datei pro Verzeichnis[/color]" & vbNewLine
                        End If
                    Case "16"
                        Convert &= "[b][color=green]Tag-Felder aufteilen[/color][/b]" & vbNewLine
                        Convert &= "[i]Feld:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Trennzeichen:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                End Select
                Convert &= vbNewLine
            Next
        Else
            Convert &= "[i]Name of action group:[/i] [b]" & Title & "[/b]" & vbNewLine & vbNewLine

            For Counter = 0 To Actions - 1
                If Actions > 1 Then
                    Convert &= "Action #" & Counter + 1 & ":" & vbNewLine
                End If
                Convert &= "[i]Action type:[/i] "
                Select Case KeyValue(Counter, "T", Filename)
                    Case "1"
                        Convert &= "[b][color=green]Case conversion[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Case conversion:[/i] "
                        Select Case KeyValue(Counter, "1", Filename)
                            Case "2"
                                Convert &= "[b]UPPER case[/b]" & vbNewLine
                            Case "4"
                                Convert &= "[b]lower case[/b]" & vbNewLine
                            Case "8"
                                Convert &= "[b]Sentence[/b]" & vbNewLine
                            Case Else
                                Convert &= "[b]Mixed Case[/b]" & vbNewLine
                        End Select
                        Convert &= "[i]Words begin from/after any of:[/i] [b]" & KeyValue(Counter, "2", Filename) & "[/b]" & vbNewLine
                    Case "2"
                        Convert &= "[b][color=green]Replace[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Original:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Replace with:[/i] [b]" & KeyValue(Counter, "2", Filename) & "[/b]" & vbNewLine
                        Select Case KeyValue(Counter, "3", Filename)
                            Case "1|0"
                                Convert &= "[color=darkblue][x] only as whole word" & vbNewLine
                                Convert &= "[ ] case-sensitive comparison[/color]" & vbNewLine
                            Case "0|1"
                                Convert &= "[color=darkblue][ ] only as whole word" & vbNewLine
                                Convert &= "[x] case-sensitive comparison[/color]" & vbNewLine
                            Case "1|1"
                                Convert &= "[color=darkblue][x] only as whole word" & vbNewLine
                                Convert &= "[x] case-sensitive comparison[/color]" & vbNewLine
                            Case Else
                                Convert &= "[color=darkblue][ ] only as whole word" & vbNewLine
                                Convert &= "[ ] case-sensitive comparison[/color]" & vbNewLine
                        End Select
                    Case "3"
                        Convert &= "[b][color=green]Shorten filenames to 64 characters[/color][/b]" & vbNewLine
                        Convert &= "[i]Mode:[/i] "
                        If KeyValue(Counter, "1", Filename) = "2" Then
                            Convert &= "[b]intelligent[/b]" & vbNewLine
                        Else
                            Convert &= "[b]cut[/b]" & vbNewLine
                        End If
                    Case "4"
                        Convert &= "[b][color=green]Replace with regular expression[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Regular expression:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Replace matches with:[/i] [b]" & KeyValue(Counter, "2", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "3", Filename) = "1" Then
                            Convert &= "[color=darkblue][x] case-sensitive comparison[/color]" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] case-sensitive comparison[/color]" & vbNewLine
                        End If
                    Case "5"
                        Convert &= "[b][color=green]Format value[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Formatstring:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "6"
                        Convert &= "[b][color=green]Remove duplicate fields[/color][/b]" & vbNewLine
                    Case "7"
                        Convert &= "[b][color=green]Guess values[/color][/b]" & vbNewLine
                        Convert &= "[i]Source format:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Guessing pattern:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "8"
                        Convert &= "[b][color=green]Merge duplicate fields[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Separator:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "9"
                        Convert &= "[b][color=green]Remove fields[/color][/b]" & vbNewLine
                        Convert &= "[i]Fields to remove (semicolon-separated):[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                    Case "10"
                        Convert &= "[b][color=green]Remove fields except[/color][/b]" & vbNewLine
                        Convert &= "[i]Fields to leave (semicolon-separated):[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                    Case "11"
                        Convert &= "[b][color=green]Convert codepage[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Codepage:[/i] [b]" & Globalization.CultureInfo.GetCultureInfo(CInt(KeyValue(Counter, "1", Filename))).EnglishName & " - " & Globalization.CultureInfo.GetCultureInfo(CInt(KeyValue(Counter, "1", Filename))).NativeName & " (" & Globalization.CultureInfo.GetCultureInfo(CInt(KeyValue(Counter, "1", Filename))).TextInfo.ANSICodePage & ")" & "[/b]" & vbNewLine
                    Case "12"
                        Convert &= "[b][color=green]Import cover from file[/color][/b]" & vbNewLine
                        Convert &= "[i]Format string for image filename:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "2", Filename) = "1" Then
                            Convert &= "[color=darkblue][x] Delete existing cover art[/color]" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Delete existing cover art[/color]" & vbNewLine
                        End If
                    Case "13"
                        Convert &= "[b][color=green]Export cover to file[/color][/b]" & vbNewLine
                        Convert &= "[i]Format string for image filename:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "2", Filename) = "1" Then
                            Convert &= "[color=darkblue][x] Export duplicate covers[/color]" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Export duplicate covers[/color]" & vbNewLine
                        End If
                    Case "14"
                        Convert &= "[b][color=green]Import text file[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Filename:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                    Case "15"
                        Convert &= "[b][color=green]Export[/color][/b]" & vbNewLine
                        Convert &= "[i]Select export file:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Export file name:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                        If KeyValue(Counter, "2", Filename) Then
                            Convert &= "[color=darkblue][x] Append data" & vbNewLine
                        Else
                            Convert &= "[color=darkblue][ ] Append data" & vbNewLine
                        End If
                        If KeyValue(Counter, "3", Filename) Then
                            Convert &= "[x] One file per directory[/color]" & vbNewLine
                        Else
                            Convert &= "[ ] One file per directory[/color]" & vbNewLine
                        End If
                    Case "16"
                        Convert &= "[b][color=green]Split fields by separator[/color][/b]" & vbNewLine
                        Convert &= "[i]Field:[/i] [b]" & KeyValue(Counter, "F", Filename) & "[/b]" & vbNewLine
                        Convert &= "[i]Separator:[/i] [b]" & KeyValue(Counter, "1", Filename) & "[/b]" & vbNewLine
                End Select
                Convert &= vbNewLine
            Next
        End If

        Convert = Convert.Replace(":[/i] [b][/b]" & vbNewLine, ":[/i]" & vbNewLine).Trim
    End Function

    Private Function KeyValue(ByVal Action As Integer, ByVal Key As String, ByVal Filename As String) As String
        Dim Length As Integer

        KeyValue = Space(BufferSize)
        Length = GetPrivateProfileStringW("#" & Action, Key, vbNullString, KeyValue, BufferSize, Filename)
        KeyValue = RegularExpressions.Regex.Unescape(KeyValue.Substring(0, Length))
    End Function

    Private Sub MainForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        uxLanguage.Text = "English"
        uxOpenFile.InitialDirectory = System.Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) & "\Mp3tag\data\actions"

        If (My.Application.CommandLineArgs.Count = 1) AndAlso (File.Exists(My.Application.CommandLineArgs(0))) Then
            Dim TemporaryFilename As String = System.Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) & "\mtaconv" & System.DateTime.Now.ToBinary

            uxOpenFile.FileName = My.Application.CommandLineArgs(0)
            uxFile.Text = uxOpenFile.FileName
            Try
                File.WriteAllText(TemporaryFilename, File.ReadAllText(uxOpenFile.FileName))
                uxBBCode.Text = Convert(TemporaryFilename, uxOpenFile.SafeFileName.Substring(0, uxOpenFile.SafeFileName.LastIndexOf(".")), uxLanguage.SelectedIndex)
                File.Delete(TemporaryFilename)
            Catch ex As Exception
                uxBBCode.Text = ""
            End Try
        End If
    End Sub

    Private Sub uxLanguage_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles uxLanguage.SelectedIndexChanged
        Dim TemporaryFilename As String = System.Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) & "\mtaconv" & System.DateTime.Now.ToBinary

        Try
            File.WriteAllText(TemporaryFilename, File.ReadAllText(uxOpenFile.FileName))
            uxBBCode.Text = Convert(TemporaryFilename, uxOpenFile.SafeFileName.Substring(0, uxOpenFile.SafeFileName.LastIndexOf(".")), uxLanguage.SelectedIndex)
            File.Delete(TemporaryFilename)
        Catch ex As Exception
            uxBBCode.Text = ""
        End Try
    End Sub

    Private Sub uxExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles uxExit.Click
        Close()
    End Sub

    Private Sub uxCopy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles uxCopy.Click
        If uxBBCode.Text.Length > 0 Then
            Clipboard.Clear()
            Clipboard.SetText(uxBBCode.Text)
        End If
    End Sub
End Class