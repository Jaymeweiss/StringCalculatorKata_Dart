import 'package:test/test.dart';
import 'StringCalculator.dart';

void main() {
  test("should_return_zero_for_empty_string", () {
    expect(StringCalculator.sum(""), 0);
  });

  test("should_return_same_number_for_single_digit", () {
    expect(StringCalculator.sum("1"), 1);
  });

  test("should_return_sum_for_2_numbers", () {
    expect(StringCalculator.sum("1,2"), 3);
  });

  test("should_return_sum_for_any_number_of_values", () {
    expect(StringCalculator.sum("1,2,3,4,5"), 15);
  });
  
  test("should_return_sum_for_new_line_separated_string", () {
    expect(StringCalculator.sum("1,2,3\n4\n5"), 15);
  });

  test("should_return_sum_for_custom_delimitered_string", () {
    expect(StringCalculator.sum("//*\n1*2*3"), 6);
  });

  test("should_throw_error_if_negative_numbers_found", () {
    expect(() => StringCalculator.sum("1,-2,3,-4"), throwsA(predicate((e) => e is FormatException && e.message == "Negatives are not allowed: -2, -4")));
  });

  test("should_ignore_numbers_larger_than_1000", () {
    expect(StringCalculator.sum("1,2,1001,3"), 6);
  });

  test("should_allow_custom_delimiters_of_any_length", () {
    expect(StringCalculator.sum("//[***]\n1***2***3***4"), 10);
  });

  test("should_allow_muliple_custom_delimiters", () {
    expect(StringCalculator.sum("//[#][@]\n1@2#3"), 6);
  });

  test("should_return_sum_for_multiple_mutli_length_delimiters", () {
    expect(StringCalculator.sum("//[&&][***]\n1***2&&3***4"), 10);
  });

}
