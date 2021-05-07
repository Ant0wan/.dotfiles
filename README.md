<br />
<p align="center">
  <a href="https://github.com/Ant0wan/config-script">
    <img src="assets/logo.png" alt="Logo" width="90" height="80">
  </a>

  <h1 align="center">Config</h1>

  <p align="center">
     Configure environment from yaml file.
    <br />
    <a href="https://github.com/Ant0wan/config-script/issues">Report Bug or Request Feature</a>
  </p>
</p>



## Table of Contents

* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Acknowledgements](#acknowledgements)



## About The Project

The `setup.sh` will configure your environment such as:

- adding a custom .vimrc,

- restoring your 42 Network credentials,

- adding kubernetes command line completion,

- adding your Git credentials.

## Getting Started

Before executing `setup.sh`, your preferences need to be set in `config.yaml` file.

Section | Field | Description |
--- | --- | --- |
_42 | active | `true`: will add 42 credentials below |
_42 | recovery | `true`: will execute a script customizing 42 MacOS style |
_42 | user | `<username>`: your 42 Network login |
_42 | email | `<email>`: your 42 Network email |
Git | active | `true`: will execute Git config below |
Git | name | `<user.name>`: your Git username for git commit |
Git | email | `<email>`: your Git email for git commit |
Kubernetes | active | `true`: will execute Kubernetes config below |
Kubernetes | autocompletion | `true`: will add kubectl bash autocompletion permanently |
Kubernetes | alias | `<alias>`: add an alias for kubectl with its autocompletion |
Vim | active | `true`: will execute Vim config below |
Git | replace | `true`: will replace or add missing line to .vimrc, otherwise it won't change your config |



### Prerequisites

Only Bash > 4.4.

## Usage

After cloning repository, edit `config.yaml` depending on your needs.

Then,
```shell=
chmod +x setup.sh
```

Use,
```shell=
./setup.sh
```

Done !


## Roadmap

See the [open issues](https://github.com/Ant0wan/config-script/issues) for a list of proposed features (and known issues).


## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

No License

## Acknowledgements

Thanks to [pkuczynski](https://gist.github.com/pkuczynski/8665367) and [jasperes](https://github.com/jasperes/bash-yaml)
