/// Centralized string constants and labels for the kiosk interface.
class KioskStrings {
  KioskStrings._();

  static const String appTitle = 'CH Self-Print Kiosk';
  static const String brandTitle = 'Campus Hub';
  static const String brandSubtitle = 'Autonomous Print Station';

  // QR Code & Scan Section
  static const String scanToPrintTitle = 'Scan To Print';
  static const String scanToPrintSubtitle =
      'Point your mobile camera or CampusHub App to begin printing';
  static const String kioskIdLabel = 'KIOSK ID';
  static const String step1Title = 'Scan QR Code';
  static const String step1Desc = 'Use camera or CampusHub App';
  static const String step2Title = 'Select Files';
  static const String step2Desc = 'PDF, DOCX, PPTX & Images';
  static const String step3Title = 'Collect Prints';
  static const String step3Desc = 'Released immediately below';

  // Printer Status Section
  static const String printerStatusTitle = 'Printer Telemetry';
  static const String printerModel = 'HP PageWide Enterprise 780dn';
  static const String printerLocationLabel = 'LOCATION';
  static const String printerHealthLabel = 'PRINTER HEALTH';
  static const String statusOnline = 'READY TO PRINT';
  static const String statusPrinting = 'PROCESSING PRINT JOB...';
  static const String statusLowPaper = 'PAPER TRAY LOW';
  static const String statusMaintenance = 'SCHEDULED MAINTENANCE';

  // Gauges
  static const String paperTrayA4 = 'Tray 1 (A4 Plain 80g)';
  static const String paperTrayA3 = 'Tray 2 (A3 & Heavy 100g)';
  static const String tonerLevelsTitle = 'Toner Consumables';
  static const String queueTitle = 'Active Print Queue';
  static const String queueEmpty = 'No pending jobs (Instant)';

  // Footer & Help
  static const String helpdeskHotline = 'Helpdesk: +60 3-8890 1200';
  static const String helpdeskEmail = 'support@campushub.edu.my';
  static const String whatsappSupport = 'WhatsApp: +60 12-345 6789';
}
