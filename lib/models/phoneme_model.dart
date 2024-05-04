// Vowel
class Phoneme {
  final String symbol;
  final String description;
  final String imageSrc;

  Phoneme(
      {required this.symbol,
        required this.description,
        required this.imageSrc});
}

List<Phoneme> vowels = [
  Phoneme(
      symbol: 'i',
      description: 'Close front unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɪ',
      description: 'The lips are relaxed and the central/front area of the tongue is in the central/high area of the mouth for this sound. The overall neutrality and relaxed tongue and lip position is why it is one of the pronunciations used in an unstressed vowel position.',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'e',
      description: 'Close-mid front unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'æ',
      description: 'Near-open front unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɑ',
      description: 'Open back unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɒ',
      description: 'Open back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɔ',
      description: 'Open-mid back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'oʊ',
      description: 'Close-mid back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'u',
      description: 'Close back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ʊ',
      description: 'Near-close near-back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ʌ',
      description: 'Open-mid back unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɜ',
      description: 'Open-mid central unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ə',
      description: 'Mid-central vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'eɪ',
      description: 'Close-mid front unrounded vowel diphthong',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'aɪ',
      description: 'Open front unrounded vowel diphthong',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
];

// consonants
List<Phoneme> consonants = [
  Phoneme(
      symbol: 'p',
      description: 'Voiceless bilabial plosive',
      imageSrc: 'assets/images/vowels_1.png'),
  Phoneme(
      symbol: 'b',
      description: 'Voiced bilabial plosive',
      imageSrc: 'assets/images/vowels_1.png'),
  Phoneme(
      symbol: 't',
      description: 'Voiceless alveolar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'd',
      description: 'Voiced alveolar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'k',
      description: 'Voiceless velar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'g',
      description: 'Voiced velar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'f',
      description: 'The f sound /f/ is unvoiced (the vocal cords do not vibrate during its production), and is the counterpart to the voiced v sound /V/.To create the /f/, the jaw is held nearly closed. The upper backside of the bottom lip is pressed very lightly into the bottom of the top teeth. Air is pushed out the mouth between the top teeth and the upper backside of the bottom lip. This sound is to be a continuous consonant, meaning that it should be capable of being produced for a few seconds with even and smooth pronunciation for the entire duration.',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'v',
      description: 'Voiced labiodental fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'θ',
      description: 'Voiceless dental fricative (think)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ð',
      description: 'Voiced dental fricative (this)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 's',
      description: 'Voiceless alveolar fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'z',
      description: 'Voiced alveolar fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ʃ',
      description: 'Voiceless postalveolar fricative (shoe)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ʒ',
      description: 'Voiced postalveolar fricative (measure)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ʧ',
      description: 'Voiceless postalveolar affricate (chair)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ʤ',
      description: 'Voiced postalveolar affricate (judge)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'm',
      description: 'Bilabial nasal',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'n',
      description: 'Alveolar nasal',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ŋ',
      description: 'Velar nasal (sing)',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'l',
      description: 'Alveolar lateral approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'r',
      description: 'Alveolar approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɹ',
      description: 'Postalveolar approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'h',
      description: 'Voiceless glottal fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'w',
      description: 'Voiced labio-velar approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
];

// R controlled vowels
List<Phoneme> rControlledVowels = [
  Phoneme(
      symbol: 'ɑr',
      description: 'Start, car, far',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɛr',
      description: 'Terror, error, very',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɪr',
      description: 'First, bird, flirt',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
  Phoneme(
      symbol: 'ɔr',
      description: 'Fort, more, door',
      imageSrc: 'assets/images/phoneme/vowels_1.png'),
];

