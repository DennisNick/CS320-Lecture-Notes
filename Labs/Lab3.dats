
datatype mytree(a:t@ype) = 
  | TreeLeaf of ()    // () -> mytree a
  | TreeNode of (a, mytree a, mytree a) // (a,mytree a, myreee a) -> mytree a    
// TreeNode is the varient
// a is payload, second is left, third is right


case t of 
  | TreeLeaf ()
  | TreeNode (payloard, left, right)
// These are called the patterns to a case statement.
// case+ checks all cases, throws error if not
// case- does not throw an error
// val also has these possible suffices
// val- TreeNode(p, l, r) = t

/* In summary, we used inside t@ypes to construct, and good ol pattern 
 * checking to deconstruct 
 */
