#convert .txt files to json
#expects two arguments: name of the file to convert and name of the output file
import json
import sys


filename = str(sys.argv[1])
jsonFile = str(sys.argv[2])


def json_converter(filename: str, output: str) -> None:
    #dictionary to store lines from .txt
    dict1 = {}

    #create dictionary
    with open(filename) as fn:
        for line in fn:
            #go line by line extracting only the words
            command, description = line.strip().split(None, 1)
            dict1[command] = description.strip()

    #create json file
    #out_file = open(output, "w")
    with open( output, "w", encoding="utf-8" ) as f:
        json.dump(dict1, f, ensure_ascii=False, indent = 4)
    #out_file.close()


#json_converter("flux_distribution_fba_glucose.txt", "output.json")
json_converter(filename, jsonFile)