// You can edit this code!
// Click here and start typing.
package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	text, t1, t2 := reader.ReadLine();
	t, t3 := text.ReadString('\n')
	fmt.Println(t1)
	fmt.Println(t2)
	fmt.Pringln(t3)
	fmt.Println(strings.TrimSpace(t))
}
