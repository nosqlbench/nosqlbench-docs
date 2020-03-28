---
title: general functions
weight: 20
---

These functions have no particular category, so they ended up here by default.

## WeightedStringsFromCSV

Provides sampling of a given field in a CSV file according to discrete probabilities. The CSV file must have headers which can be used to find the named columns for value and weight. The value column contains the string result to be returned by the function. The weight column contains the floating-point weight or mass associated with the value on the same line. All the weights are normalized automatically.

If there are multiple file names containing the same format, then they
will all be read in the same way.

If the first word in the filenames list is 'map', then the values will not
be pseudo-randomly selected. Instead, they will be mapped over in some
other unsorted and stable order as input values vary from 0L to Long.MAX_VALUE.

Generally, you want to leave out the 'map' directive to get "random sampling"
of these values.

This function works the same as the three-parametered form of WeightedStrings,
which is deprecated in lieu of this one. Use this one instead.

- long -> WeightedStringsFromCSV(java.lang.String: valueColumn, java.lang.String: weightColumn, java.lang.String[]...: filenames) -> java.lang.String
  - *notes:* Create a sampler of strings from the given CSV file. The CSV file must have plain CSV headers
as its first line.
@param valueColumn The name of the value column to be sampled
@param weightColumn The name of the weight column, which must be parsable as a double
@param filenames One or more file names which will be read in to the sampler buffer


## CSVFrequencySampler

Takes a CSV with sample data and generates random values based on the relative frequencies of the values in the file. The CSV file must have headers which can be used to find the named columns. I.E. take the following imaginary \`animals.csv\` file: animal,count,country puppy,1,usa puppy,2,colombia puppy,3,senegal kitten,2,colombia \`CSVFrequencySampler('animals.csv', animal)\` will return \`puppy\` or \`kitten\` randomly. \`puppy\` will be 3x more frequent than \`kitten\`. \`CSVFrequencySampler('animals.csv', country)\` will return \`usa\`, \`colombia\`, or \`senegal\` randomly. \`colombia\` will be 2x more frequent than \`usa\` or \`senegal\`. Use this function to infer frequencies of categorical values from CSVs.

- long -> CSVFrequencySampler(java.lang.String: filename, java.lang.String: columnName) -> java.lang.String
  - *notes:* Create a sampler of strings from the given CSV file. The CSV file must have plain CSV headers
as its first line.
@param filename The name of the file to be read into the sampler buffer
@param columnName The name of the column to be sampled

  - *ex:* `CSVFrequencySampler('values.csv','modelno')`
  - *Read values.csv, count the frequency of values in 'modelno' column, and sample from this column proportionally*

## DelimFrequencySampler

Takes a CSV with sample data and generates random values based on the relative frequencies of the values in the file. The CSV file must have headers which can be used to find the named columns. I.E. take the following imaginary \`animals.csv\` file: animal,count,country puppy,1,usa puppy,2,colombia puppy,3,senegal kitten,2,colombia \`CSVFrequencySampler('animals.csv', animal)\` will return \`puppy\` or \`kitten\` randomly. \`puppy\` will be 3x more frequent than \`kitten\`. \`CSVFrequencySampler('animals.csv', country)\` will return \`usa\`, \`colombia\`, or \`senegal\` randomly. \`colombia\` will be 2x more frequent than \`usa\` or \`senegal\`. Use this function to infer frequencies of categorical values from CSVs.

- long -> DelimFrequencySampler(java.lang.String: filename, java.lang.String: columnName, char: delimiter) -> java.lang.String
  - *notes:* Create a sampler of strings from the given delimited file. The delimited file must have plain headers
as its first line.
@param filename The name of the file to be read into the sampler buffer
@param columnName The name of the column to be sampled
@param delimiter delimmiter

  - *ex:* `DelimFrequencySampler('values.csv','modelno', '|')`
  - *Read values.csv, count the frequency of values in 'modelno' column, and sample from this column proportionally*

