main(List<String> args) {
  List<num> l1 = null;
  List<num> l2 = [1, 2, 3];
  List<num> l3 = [1, 2, 4];

  Set<num> s1 = Set.from(l1 ?? []);
  Set<num> s2 = Set.from(l2);
  Set<num> s3 = Set.from(l3);

  print(s1.difference(s2).length);
  print(s1.difference(s3).length);
}