   M S B A M L   `   `   `  ����K  GSENB ENB Manager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null3clr-namespace:SENB_ENB_ManagerSENB_ENB_Manager  5      '    !SENB_ENB_Manager.EditBinariesView   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      0localclr-namespace:SENB_ENB_Manager     5      U QMaterialDesignThemes.Wpf, Version=2.3.0.823, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5         MaterialDesignBody#���   5        MaterialDesignPaper#���  5	      $��Regular"�5
      $��13(�5      &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5         TextRenderingMode$
 Auto=�5      $X��Rpack://application:,,,/MaterialDesignThemes.Wpf;component/Resources/Roboto/#Roboto)�5      .��5      � $	��580��6   $	��398��6   .+�5   
   ��   MaterialDesignToolButton#��[ 6   $
��Left=�6C   $��5,5,0,0q�6^   $	��Top=�6o     DialogHandler � DataContext# [ 5      )  #MaterialDesignThemes.Wpf.DialogHost   CloseDialogCommand#��Z 5      .��5      '  !MaterialDesignThemes.Wpf.PackIcon  �  �ControlzEx.PackIconBase`1[[MaterialDesignThemes.Wpf.PackIconKind, MaterialDesignThemes.Wpf, Version=2.3.0.823, Culture=neutral, PublicKeyToken=null]]   Kind$ 	ArrowLeft=�6&   #���   67   $��25��6u   $
��Auto��6�   5      �� 5   
   #��[ 6   $��Right=�6C   $��0,5,5,0q�6_   $	��Top=�6p   .��5        $
 Plus=�6&   #���   62   $��25��6p   $
��Auto��6{   5      �� 5   
   .+�5       �� $��Center=�6   $��0,0,0,5q�61   $��29(�6B   .��6P   
Binaries6Z   �� 5#      $��13(�6   $
��Wrap=�6&   $��5,0,5,10q�6:    �� TextAlignment$ Center=�6L   qoEnable or disable the binary using the button on the left. Add binaries by using the button on the upper right.6�   �� 5&      ��6   �� *
Binaries+��5'      �� 5(      .R�5)      ��  ��Name$ Border��6!    �� Padding$ 8q�61   $��0 0 0 1q�6=     MaterialDesignDivider#���  6W   ._�5*      � .+�5+   "   d� $��Center=�6/    ) %MaterialDesignActionLightToggleButton#��[ 5,   /   $
��Left=�6n    d� 	IsChecked 5+   J   �� *
IsSelected+.��5-   &     $ Close=�6>   5.   #   �� 50   "   $��50,0,0,0q�6-   .+�51   &   �� $
��Bold"�60   $��16(�6X   ��6B   �� *Name+6X   �� 52   &   $��14(�6N   ��60   �� *FileLocation+6N   53   #   �� 55   "   #��[ 6)   $��Right=�6[   .��56   &     $ DeleteForever=�6>   $
��Auto��6S   $��20��6a   57   #   58      59      	 �� Triggers	 5:      �� 5;      
 �� Value$

 True��6I    �� Binding 6*   �� *
IsSelected+.a�5<   "   ��  �� 
TargetName$ Border��6)     MaterialDesignSelection �� Value# �  6S    �� Property � ��5=      5?      5A      5C      5E      5H      