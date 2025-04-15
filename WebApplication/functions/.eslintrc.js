module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    ecmaVersion: 2018,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "no-restricted-globals": ["error", "name", "length"],
    "prefer-arrow-callback": "error",
    "quotes": ["error", "double", {"allowTemplateLiterals": true}],
    // Increase max-len to 120 characters (instead of default 80)
    "max-len": ["error", { "code": 120 }],
    // Set indent to 2 spaces
    "indent": ["error", 2],
    // Disable trailing comma rule (or set to "always-multiline" if you prefer)
    "comma-dangle": "off"
  },
  overrides: [
    {
      files: ["**/*.spec.*"],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};
