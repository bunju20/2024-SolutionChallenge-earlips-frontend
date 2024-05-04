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
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɪ',
      description: 'Near-close near-front unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'e',
      description: 'Close-mid front unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'æ',
      description: 'Near-open front unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɑ',
      description: 'Open back unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɒ',
      description: 'Open back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɔ',
      description: 'Open-mid back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'oʊ',
      description: 'Close-mid back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'u',
      description: 'Close back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ʊ',
      description: 'Near-close near-back rounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ʌ',
      description: 'Open-mid back unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɜ',
      description: 'Open-mid central unrounded vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ə',
      description: 'Mid-central vowel',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'eɪ',
      description: 'Close-mid front unrounded vowel diphthong',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'aɪ',
      description: 'Open front unrounded vowel diphthong',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
];

// consonants
List<Phoneme> consonants = [
  Phoneme(
      symbol: 'p',
      description: 'Voiceless bilabial plosive',
      imageSrc: 'assets/images/vowels_1.jpg'),
  Phoneme(
      symbol: 'b',
      description: 'Voiced bilabial plosive',
      imageSrc: 'assets/images/vowels_1.jpg'),
  Phoneme(
      symbol: 't',
      description: 'Voiceless alveolar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'd',
      description: 'Voiced alveolar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'k',
      description: 'Voiceless velar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'g',
      description: 'Voiced velar plosive',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'f',
      description: 'Voiceless labiodental fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'v',
      description: 'Voiced labiodental fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'θ',
      description: 'Voiceless dental fricative (think)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ð',
      description: 'Voiced dental fricative (this)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 's',
      description: 'Voiceless alveolar fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'z',
      description: 'Voiced alveolar fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ʃ',
      description: 'Voiceless postalveolar fricative (shoe)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ʒ',
      description: 'Voiced postalveolar fricative (measure)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ʧ',
      description: 'Voiceless postalveolar affricate (chair)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ʤ',
      description: 'Voiced postalveolar affricate (judge)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'm',
      description: 'Bilabial nasal',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'n',
      description: 'Alveolar nasal',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ŋ',
      description: 'Velar nasal (sing)',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'l',
      description: 'Alveolar lateral approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'r',
      description: 'Alveolar approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɹ',
      description: 'Postalveolar approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'h',
      description: 'Voiceless glottal fricative',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'w',
      description: 'Voiced labio-velar approximant',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
];

// R controlled vowels
List<Phoneme> rControlledVowels = [
  Phoneme(
      symbol: 'ɑr',
      description: 'Start, car, far',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɛr',
      description: 'Terror, error, very',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɪr',
      description: 'First, bird, flirt',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
  Phoneme(
      symbol: 'ɔr',
      description: 'Fort, more, door',
      imageSrc: 'assets/images/phoneme/vowels_1.jpg'),
];
