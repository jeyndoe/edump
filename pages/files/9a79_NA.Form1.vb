Imports System
Imports System.ComponentModel
Imports System.Drawing
Imports System.Runtime.InteropServices
Imports System.Windows.Forms

Namespace NA
    Public Class Form1
        Inherits Form

        ' Methods
        Public Sub New()
            Me.InitializeComponent
        End Sub

        Protected Overloads Sub Dispose(<MarshalAs(UnmanagedType.U1)> ByVal disposing As Boolean)
            If (disposing AndAlso (Not Me.components Is Nothing)) Then
                Me.components.Dispose()
            End If
            MyBase.Dispose(disposing)
        End Sub

        Private Sub InitializeComponent()
            Dim size1 As Size
            Dim size2 As Size
            Dim size3 As Size
            Dim point1 As Point
            Dim size4 As Size
            Dim point2 As Point
            Dim size5 As Size
            Dim point3 As Point
            Dim size6 As Size
            Dim point4 As Point
            Me.richTextBox1 = New RichTextBox
            Me.mainMenu1 = New MainMenu
            Me.menuItem1 = New MenuItem
            Me.menuItem2 = New MenuItem
            Me.menuItem3 = New MenuItem
            Me.menuItem4 = New MenuItem
            Me.menuItem5 = New MenuItem
            Me.menuItem6 = New MenuItem
            Me.button1 = New Button
            Me.button2 = New Button
            Me.button3 = New Button
            Me.openFileDialog1 = New OpenFileDialog
            Me.saveFileDialog1 = New SaveFileDialog
            Me.fontDialog1 = New FontDialog
            MyBase.SuspendLayout()
            Dim color3 As Color = SystemColors.HighlightText
            Me.richTextBox1.BackColor = color3
            point4 = New Point
            point4 = New Point(0, 0)
            Me.richTextBox1.Location = point4
            Me.richTextBox1.Name = "richTextBox1"
            Me.richTextBox1.RightToLeft = RightToLeft.No
            Me.richTextBox1.ScrollBars = RichTextBoxScrollBars.Vertical
            size6 = New Size
            size6 = New Size(528, 216)
            Me.richTextBox1.Size = size6
            Me.richTextBox1.TabIndex = 0
            Me.richTextBox1.Text = ""
            Dim itemArray3 As MenuItem() = New MenuItem() {Me.menuItem1, Me.menuItem4}
            Me.mainMenu1.MenuItems.AddRange(itemArray3)
            Me.menuItem1.Index = 0
            Dim itemArray2 As MenuItem() = New MenuItem() {Me.menuItem2, Me.menuItem3}
            Me.menuItem1.MenuItems.AddRange(itemArray2)
            Me.menuItem1.Text = "&File"
            Me.menuItem2.Index = 0
            Me.menuItem2.Text = "Open"
            AddHandler Me.menuItem2.Click, New EventHandler(AddressOf Me.menuItem2_Click)
            Me.menuItem3.Index = 1
            Me.menuItem3.Text = "Save"
            AddHandler Me.menuItem3.Click, New EventHandler(AddressOf Me.menuItem3_Click)
            Me.menuItem4.Index = 1
            Dim itemArray1 As MenuItem() = New MenuItem() {Me.menuItem5, Me.menuItem6}
            Me.menuItem4.MenuItems.AddRange(itemArray1)
            Me.menuItem4.Text = "&Edit"
            Me.menuItem5.Index = 0
            Me.menuItem5.Text = "Font"
            AddHandler Me.menuItem5.Click, New EventHandler(AddressOf Me.menuItem5_Click)
            Me.menuItem6.Index = 1
            Me.menuItem6.Text = "Cls"
            AddHandler Me.menuItem6.Click, New EventHandler(AddressOf Me.menuItem6_Click)
            Me.button1.Cursor = Cursors.Cross
            point3 = New Point
            point3 = New Point(0, 216)
            Me.button1.Location = point3
            Me.button1.Name = "button1"
            size5 = New Size
            size5 = New Size(168, 24)
            Me.button1.Size = size5
            Me.button1.TabIndex = 1
            Me.button1.Text = "Open"
            AddHandler Me.button1.Click, New EventHandler(AddressOf Me.menuItem2_Click)
            Me.button2.Cursor = Cursors.Cross
            point2 = New Point
            point2 = New Point(168, 216)
            Me.button2.Location = point2
            Me.button2.Name = "button2"
            size4 = New Size
            size4 = New Size(176, 23)
            Me.button2.Size = size4
            Me.button2.TabIndex = 2
            Me.button2.Text = "Save"
            AddHandler Me.button2.Click, New EventHandler(AddressOf Me.menuItem3_Click)
            Me.button3.Cursor = Cursors.Cross
            point1 = New Point
            point1 = New Point(344, 216)
            Me.button3.Location = point1
            Me.button3.Name = "button3"
            size3 = New Size
            size3 = New Size(184, 23)
            Me.button3.Size = size3
            Me.button3.TabIndex = 3
            Me.button3.Text = "Font"
            AddHandler Me.button3.Click, New EventHandler(AddressOf Me.menuItem5_Click)
            Me.openFileDialog1.Filter = "Edt files (*edt)|*.edt"
            Me.saveFileDialog1.Filter = "Edt files (*edt)|*.edt"
            size2 = New Size
            size2 = New Size(5, 13)
            Me.AutoScaleBaseSize = size2
            Dim color1 As Color = Color.DarkGray
            Me.BackColor = color1
            size1 = New Size
            size1 = New Size(526, 239)
            MyBase.ClientSize = size1
            MyBase.Controls.Add(Me.button3)
            MyBase.Controls.Add(Me.button2)
            MyBase.Controls.Add(Me.button1)
            MyBase.Controls.Add(Me.richTextBox1)
            MyBase.FormBorderStyle = FormBorderStyle.Fixed3D
            MyBase.MaximizeBox = False
            MyBase.Menu = Me.mainMenu1
            MyBase.Name = "Form1"
            MyBase.ShowInTaskbar = False
            MyBase.StartPosition = FormStartPosition.CenterScreen
            Me.Text = "TextEdt"
            MyBase.ResumeLayout(False)
        End Sub

        Private Sub menuItem2_Click(ByVal sender As Object, ByVal e As EventArgs)
            If (Me.openFileDialog1.ShowDialog = DialogResult.OK) Then
                Me.richTextBox1.LoadFile(Me.openFileDialog1.FileName)
            End If
        End Sub

        Private Sub menuItem3_Click(ByVal sender As Object, ByVal e As EventArgs)
            If (Me.saveFileDialog1.ShowDialog = DialogResult.OK) Then
                Me.richTextBox1.SaveFile(Me.saveFileDialog1.FileName)
            End If
        End Sub

        Private Sub menuItem5_Click(ByVal sender As Object, ByVal e As EventArgs)
            If (Me.fontDialog1.ShowDialog = DialogResult.OK) Then
                Me.richTextBox1.Font = Me.fontDialog1.Font
            End If
        End Sub

        Private Sub menuItem6_Click(ByVal sender As Object, ByVal e As EventArgs)
            Me.richTextBox1.Clear()
        End Sub


        ' Fields
        Private button1 As Button
        Private button2 As Button
        Private button3 As Button
        Private components As Container
        Private fontDialog1 As FontDialog
        Private mainMenu1 As MainMenu
        Private menuItem1 As MenuItem
        Private menuItem2 As MenuItem
        Private menuItem3 As MenuItem
        Private menuItem4 As MenuItem
        Private menuItem5 As MenuItem
        Private menuItem6 As MenuItem
        Private openFileDialog1 As OpenFileDialog
        Private richTextBox1 As RichTextBox
        Private saveFileDialog1 As SaveFileDialog
    End Class
End Namespace

