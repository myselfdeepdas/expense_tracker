import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
   
  
    "type": "service_account",
    "project_id": "flutter-gsheets-365015",
    "private_key_id": "4803478e879b7e4ca51da14d53990f388329d6f5",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDvfXCe8gZ1dG1H\nYPR600odIv7a3F935hIyfkVg3rpZ7gD3rM5eyboA4/Z3sOOxy00vYuIyg6ebH6t3\ny9USICxelzS7tXcDSBzzuXqtt93WyS9+vcwH/sLhvq/ozrlfkBCHsWdqN83CjmUt\nL6aD5OnKvUpHxDeyWT7F2BY98sxMA0IvT4WooyKT2aWIagHoNN9Bwvhf8mCe5D6A\nxJr0LuX2GNrj2K2tx/6eDN94DVsN5/9GplrRnFjUAXLLD7WE9FXHWEtJ5Ae3jTyp\nbmdE93z8jRCLxvatHipNlBJstXRUdVUp6BdkYvJ6r8jv5kURWpxM10Wj1eFEZZtE\nVLmJ19DhAgMBAAECggEAdISt3g832D54ioFgAUA6b1me8EHGyxFrahioTZyfwvA6\nlUYEs/ZmoldHC23LIi4dFACCt/v4+E6cwLCxrltr6uubMvZzfGvB9kyYJNvvuTfx\n/TJ/iaZID8gUUur9IsL3X+WOwI189PsNu8HSvJoLq2GUOb18MbAdC+n5zFMMVbBR\nOM8KOmlQcg4UIHIcrmvizXyUi7cW4Lslg1OtB1mGLDCsM/41HRVZPEHm5Rct8+hL\nw8GxJT9Gk40zgSdJeVJeMClF6vnRIIIBkexvs/Hb2QwsjAXDrZ1AN1gc8lPJRH5Y\nmatQ9LRo9ekDkYbbDnk6hPz+AkucEFo5OkeyOjDztwKBgQD52aZe5vM8i8ynp+fw\naQVMlySgQIAQVF3xLeIgh22rkmL2ilYB1YEhAd6ugLa/ooIZYY80N93oloqMQtp5\ni5GdV43By2bk01VwXrYMCNPMrlpU23gOijk/o9ekADFpxQ6QPXB7pwMMVgMN/7mf\nSDL8r459xJvZhpukg4mqzYpOZwKBgQD1YoI1L0JCaDLWcZXUfYHdlmtQOWX3/htj\nuWC+QFXfLGPKhBFCt+WzDpWuK5Od98teIv8MoMw6rH7aPslylKeK6d9OiHuR4tLr\nofCvVz93OuB6Y7Uot2LXMEdh1+XtPrpV4uK279ghwxPlQd0BhwMHUuDCtQr0de76\nzK8xnP5JdwKBgQCoSO8EUO5YQ5lO+4r/pN0K32qt/YPEe+7ieZMrccxumaTKhha0\nGYhmIQpJ4yw0G1MhoVKBS3fOJ0eefZEF+PnVTpmOhGADlEyh6UkZBgEShgUVztUo\nhfVVZhfiwLaHlVDf2mIfBzjIYE6iaTIvlMOy6tRA5eJLO50ty+M4BkU31QKBgBE/\n5oVUmCTQ7Fn0zCKO3BU2oL6X+loPi99bxbg6D49LsIwo8omtIcGPkegXeh4NsEci\n0KkTmKe7PoObDFA4sPpr7F257G3Z8xfLX38D9BsukV8pKS/+jD0yUKJJKgmecjzd\nYTCY9amR7BEeqymTUxwtsE0fqvB6Zd1NjDdBoQKLAoGAUaZAyFFv61SxG9BJaGp0\nwJIcJ12lbjXNnY9Pg7GQaGSXWQkpeQ0oEZ+bm7yj+D6XBRF5mq717GvNPGv3aZRF\nkADvWwCuGCLrjLBPwtolWdueZWr9Wm7IZKKwyplD7BQjX56jmb22e70tKk9ibujw\nSoEJ3W2Mm0XC460+ixF9Fic=\n-----END PRIVATE KEY-----\n",
    "client_email": "flutter-gsheets@flutter-gsheets-365015.iam.gserviceaccount.com",
    "client_id": "110233640574095152516",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-365015.iam.gserviceaccount.com"
  
  
  }
  ''';
  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1bkCwtydKOq8JoCVrZ0BuHhwRkkg5JVSpn296H1gjcNk';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
