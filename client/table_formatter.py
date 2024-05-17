

def table_formatter(headings: list, content: list):

    table = "<table>"
    for row in content:
        table += "<tr>"
        for column in row:
            table += f"<td>{column}</td>"
        table += "</tr>"
    table += "</table>"
    return table

if __name__ == "__main__":
    table_formatter([], [("hell", "kjh", "jh")])
