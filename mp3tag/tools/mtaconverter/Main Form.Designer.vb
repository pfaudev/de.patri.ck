<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class MainForm
    Inherits System.Windows.Forms.Form

    'Das Formular überschreibt den Löschvorgang, um die Komponentenliste zu bereinigen.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer

    'Hinweis: Die folgende Prozedur ist für den Windows Form-Designer erforderlich.
    'Das Bearbeiten ist mit dem Windows Form-Designer möglich.  
    'Das Bearbeiten mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.uxFileGroup = New System.Windows.Forms.GroupBox
        Me.uxBrowse = New System.Windows.Forms.Button
        Me.uxFile = New System.Windows.Forms.TextBox
        Me.uxBBCodeGroup = New System.Windows.Forms.GroupBox
        Me.uxLanguage = New System.Windows.Forms.ComboBox
        Me.uxBBCode = New System.Windows.Forms.TextBox
        Me.uxOpenFile = New System.Windows.Forms.OpenFileDialog
        Me.uxExit = New System.Windows.Forms.Button
        Me.uxCopy = New System.Windows.Forms.Button
        Me.uxFileGroup.SuspendLayout()
        Me.uxBBCodeGroup.SuspendLayout()
        Me.SuspendLayout()
        '
        'uxFileGroup
        '
        Me.uxFileGroup.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.uxFileGroup.Controls.Add(Me.uxBrowse)
        Me.uxFileGroup.Controls.Add(Me.uxFile)
        Me.uxFileGroup.Location = New System.Drawing.Point(8, 8)
        Me.uxFileGroup.Name = "uxFileGroup"
        Me.uxFileGroup.Size = New System.Drawing.Size(368, 48)
        Me.uxFileGroup.TabIndex = 0
        Me.uxFileGroup.TabStop = False
        Me.uxFileGroup.Text = "MTA &File:"
        '
        'uxBrowse
        '
        Me.uxBrowse.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.uxBrowse.Location = New System.Drawing.Point(304, 15)
        Me.uxBrowse.Name = "uxBrowse"
        Me.uxBrowse.Size = New System.Drawing.Size(56, 22)
        Me.uxBrowse.TabIndex = 1
        Me.uxBrowse.Text = "&Browse"
        Me.uxBrowse.UseVisualStyleBackColor = True
        '
        'uxFile
        '
        Me.uxFile.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.uxFile.BackColor = System.Drawing.SystemColors.Window
        Me.uxFile.Location = New System.Drawing.Point(8, 16)
        Me.uxFile.Name = "uxFile"
        Me.uxFile.ReadOnly = True
        Me.uxFile.Size = New System.Drawing.Size(288, 20)
        Me.uxFile.TabIndex = 0
        '
        'uxBBCodeGroup
        '
        Me.uxBBCodeGroup.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.uxBBCodeGroup.Controls.Add(Me.uxLanguage)
        Me.uxBBCodeGroup.Controls.Add(Me.uxBBCode)
        Me.uxBBCodeGroup.Location = New System.Drawing.Point(8, 64)
        Me.uxBBCodeGroup.Name = "uxBBCodeGroup"
        Me.uxBBCodeGroup.Size = New System.Drawing.Size(368, 259)
        Me.uxBBCodeGroup.TabIndex = 1
        Me.uxBBCodeGroup.TabStop = False
        Me.uxBBCodeGroup.Text = "&BBCode:"
        '
        'uxLanguage
        '
        Me.uxLanguage.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.uxLanguage.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.uxLanguage.FormattingEnabled = True
        Me.uxLanguage.Items.AddRange(New Object() {"English", "German"})
        Me.uxLanguage.Location = New System.Drawing.Point(8, 16)
        Me.uxLanguage.Name = "uxLanguage"
        Me.uxLanguage.Size = New System.Drawing.Size(352, 21)
        Me.uxLanguage.Sorted = True
        Me.uxLanguage.TabIndex = 1
        '
        'uxBBCode
        '
        Me.uxBBCode.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.uxBBCode.BackColor = System.Drawing.SystemColors.Window
        Me.uxBBCode.Location = New System.Drawing.Point(8, 40)
        Me.uxBBCode.Multiline = True
        Me.uxBBCode.Name = "uxBBCode"
        Me.uxBBCode.ReadOnly = True
        Me.uxBBCode.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.uxBBCode.Size = New System.Drawing.Size(352, 211)
        Me.uxBBCode.TabIndex = 0
        Me.uxBBCode.WordWrap = False
        '
        'uxOpenFile
        '
        Me.uxOpenFile.Filter = "MP3Tag Action Files (*.mta)|*.mta"
        '
        'uxExit
        '
        Me.uxExit.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.uxExit.Location = New System.Drawing.Point(8, 328)
        Me.uxExit.Name = "uxExit"
        Me.uxExit.Size = New System.Drawing.Size(72, 24)
        Me.uxExit.TabIndex = 2
        Me.uxExit.Text = "Exit"
        Me.uxExit.UseVisualStyleBackColor = True
        '
        'uxCopy
        '
        Me.uxCopy.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.uxCopy.Location = New System.Drawing.Point(304, 328)
        Me.uxCopy.Name = "uxCopy"
        Me.uxCopy.Size = New System.Drawing.Size(72, 24)
        Me.uxCopy.TabIndex = 3
        Me.uxCopy.Text = "&Copy"
        Me.uxCopy.UseVisualStyleBackColor = True
        '
        'MainForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(387, 360)
        Me.Controls.Add(Me.uxCopy)
        Me.Controls.Add(Me.uxExit)
        Me.Controls.Add(Me.uxBBCodeGroup)
        Me.Controls.Add(Me.uxFileGroup)
        Me.MinimumSize = New System.Drawing.Size(395, 369)
        Me.Name = "MainForm"
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "MTA Converter"
        Me.uxFileGroup.ResumeLayout(False)
        Me.uxFileGroup.PerformLayout()
        Me.uxBBCodeGroup.ResumeLayout(False)
        Me.uxBBCodeGroup.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents uxFileGroup As System.Windows.Forms.GroupBox
    Friend WithEvents uxBrowse As System.Windows.Forms.Button
    Friend WithEvents uxFile As System.Windows.Forms.TextBox
    Friend WithEvents uxBBCodeGroup As System.Windows.Forms.GroupBox
    Friend WithEvents uxBBCode As System.Windows.Forms.TextBox
    Friend WithEvents uxOpenFile As System.Windows.Forms.OpenFileDialog
    Friend WithEvents uxLanguage As System.Windows.Forms.ComboBox
    Friend WithEvents uxExit As System.Windows.Forms.Button
    Friend WithEvents uxCopy As System.Windows.Forms.Button

End Class
