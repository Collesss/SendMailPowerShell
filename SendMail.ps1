# ящики созданые за сегодня отправляем данные в массив
Get-Mailbox | Where-Object {$_.WhenCreated -gt (get-date).adddays(-1)} | foreach {
    # забираем алиас
    $alias = $_.Alias
    # фио
    $name = $_.Name
    # имя файла аттача который будет посылаться пользователю
    $file1 = 'C:\Приветственное письмо\IT памятка.pdf'
    $file2 = 'C:\Приветственное письмо\Приветственное письмо.pdf'
    # почтовый домен
    $domain = ''
    # почтовый сервер в локальном домене
    $Smtp =''
    # от кого будет идти сообщение
    $from =''
    # тема письма
    $Subject = "Мы рады приветствовать Вас в компании "
    # тело письма
    $Body = "Мы рады приветствовать Вас, $name, ознакомьтесь с правилами нашей организации, документы во вложении"
    # Конвертируем кодировку в utf8
    $enc = New-Object 'System.Text.utf8encoding'
    #отправляем сообщение
    Send-MailMessage -From $from -To $alias -Subject $Subject -Body $Body -Attachment $file1,$file2 -Encoding $enc -SmtpServer $Smtp
}