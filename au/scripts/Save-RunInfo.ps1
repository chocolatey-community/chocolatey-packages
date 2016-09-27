function Save-RunInfo {
    "Saving run info"
    try { $p = $Info.Options.Mail.Password } catch {}
    if ($p) { $Info.Options.Mail.Password='' }

    $Info | Export-CliXML update_info.xml

    if ($p) { $Info.Options.Mail.Password = $p }
}
