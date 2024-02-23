import Foundation

// Define musical alphabets with and without accidentals
let musicalAlphabetWithoutAccidentals = ["A", "B", "C", "D", "E", "F", "G"]
let musicalAlphabetWithAccidentals = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

func generateRandomLetter(from start: String, to end: String, withAccidentals: Bool) -> String {
    let musicalAlphabet = withAccidentals ? musicalAlphabetWithAccidentals : musicalAlphabetWithoutAccidentals
    let startIndex = musicalAlphabet.firstIndex(of: start) ?? 0
    var endIndex = musicalAlphabet.firstIndex(of: end) ?? musicalAlphabet.count - 1
    
    // Adjust for circular selection if the start index is greater than the end index
    if startIndex > endIndex {
        endIndex += musicalAlphabet.count
    }
    
    let randomIndex = Int.random(in: startIndex...endIndex) % musicalAlphabet.count
    return musicalAlphabet[randomIndex]
}

func main() {
    var includeAccidentals: Bool = false
    var start: String = ""
    var end: String = ""
    var numNotes: Int = 0
    var repeatLast: Bool = false

    repeat {
        if !repeatLast {
            print("Include accidentals? (yes/no): ", terminator: "")
            includeAccidentals = readLine()?.lowercased() == "yes"
            
            let musicalAlphabet = includeAccidentals ? musicalAlphabetWithAccidentals : musicalAlphabetWithoutAccidentals
            
            print("Enter the starting note (e.g., A, C# if accidentals included): ", terminator: "")
            guard let startInput = readLine(), musicalAlphabet.contains(where: { $0.caseInsensitiveCompare(startInput) == .orderedSame }) else {
                print("Invalid starting note. Exiting.")
                return
            }
            start = startInput.uppercased()

            print("Enter the ending note (e.g., B, E# if accidentals included): ", terminator: "")
            guard let endInput = readLine(), musicalAlphabet.contains(where: { $0.caseInsensitiveCompare(endInput) == .orderedSame }) else {
                print("Invalid ending note. Exiting.")
                return
            }
            end = endInput.uppercased()

            print("Enter the number of notes to generate: ", terminator: "")
            guard let numInput = readLine(), let num = Int(numInput), num > 0 else {
                print("Invalid number of notes. Exiting.")
                return
            }
            numNotes = num
        }

        print("Starting in 3 seconds...")
        Thread.sleep(forTimeInterval: 3) // 3-second intermission

        print("Generating \(numNotes) random notes between \(start) and \(end):")
        for _ in 1...numNotes {
            let note = generateRandomLetter(from: start, to: end, withAccidentals: includeAccidentals)
            print(note)
            Thread.sleep(forTimeInterval: 0.90) // Sleep for half a second
        }
        
        print("Do you want to repeat the exercise with the same options (repeat), with different options (redo), or exit (no)?", terminator: " ")
        let response = readLine()?.lowercased()
        repeatLast = response == "repeat"
        if response == "no" {
            break
        }
        // The loop will repeat with the same options if "repeat" is chosen, or start over for new options otherwise.
        
    } while true
}

main()
