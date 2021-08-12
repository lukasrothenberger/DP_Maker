def preprocess(cmd: str) -> str:
    # replace sections enclosed in quotes with §-signs
    if "\"" in cmd:
        index_block_list = []
        quotes_start_indices = []
        quotes_end_indices = []
        first_char = ""
        second_char = ""
        for idx, third_char in enumerate(cmd):
            if first_char+second_char+third_char == '\"\\\"':
                if idx-2 not in index_block_list and idx-1 not in index_block_list and idx not in index_block_list:
                    print("Found occ at: ", idx-2)
                    quotes_start_indices.append(idx-2)
                    index_block_list += [idx-2, idx-1, idx]
            if first_char + second_char + third_char == "\\\"\"":
                if idx-2 not in index_block_list and idx-1 not in index_block_list and idx not in index_block_list:
                    print("Found end occ at: ", idx - 2)
                    quotes_end_indices.append(idx - 2)
                    index_block_list += [idx - 2, idx - 1, idx]
            first_char = second_char
            second_char = third_char

        # match start and end indices of quote sections
        quote_tuples = []
        while len(quotes_start_indices) > 0 and len(quotes_end_indices) > 0:
            cur = quotes_start_indices.pop(0)
            if quotes_end_indices[0] > cur:
                quote_tuples.append((cur, quotes_end_indices[0]))
                quotes_end_indices.pop(0)

        print("cmd pre:  ", cmd)
        for quote_range in quote_tuples:
            cmd = __replace_whitespace_in_quote_range(cmd, quote_range)
        print("cmd post: ", cmd)

        cmd = cmd.replace("\"\\\"", "\"")
        cmd = cmd.replace("\\\"\"", "\"")

        print("cmd aft:  ", cmd)
    return cmd


def __replace_whitespace_in_quote_range(string, quote_range):
    cur_idx = quote_range[0]
    end_idx = quote_range[1]
    while cur_idx <= end_idx:
        if string[cur_idx] == " ":
            string = string[:cur_idx] + "§" + string[cur_idx + 1:]
        cur_idx += 1
    return string
