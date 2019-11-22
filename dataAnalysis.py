import pandas as pd

def createdataframe():
    df = pd.DataFrame
    return df


def setdataframecolumns(df, columns):
    df = pd.DataFrame(columns=columns)
    return df

def appenddatatodataframe(df, data):
    df.loc[df.index.max() + 1, :] = data