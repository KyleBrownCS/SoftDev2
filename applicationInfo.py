import os


class ApplicationInfo:

    DATABASE_FILE_NAME = "database.db"
    OBLIGATION_TABLE_NAME = "obligation"

    def __init__(self):
        self.application_filepath = os.path.dirname(os.path.abspath(__file__))
        self.database_filepath = self.application_filepath + "/" +  ApplicationInfo.DATABASE_FILE_NAME
