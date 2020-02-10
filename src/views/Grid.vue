<template>
  <div>
    <!--
      v2.0: v-row provides gutter adjustments and has 3 options available
      - regular (nothing required)
      - <v-row dense>
      - <v-row no-gutters>
    -->

    <v-container>
      <v-row>
        <v-col>
          <v-sheet class="pa-3">v-col in v-row</v-sheet>
        </v-col>
        <v-col>
          <v-sheet class="pa-3">v-col in v-row</v-sheet>
        </v-col>
      </v-row>
    </v-container>

    <v-container>
      <v-row dense>
        <v-col>
          <v-sheet class="pa-3">v-col in v-row dense</v-sheet>
        </v-col>
        <v-col>
          <v-sheet class="pa-3">v-col in v-row dense</v-sheet>
        </v-col>
      </v-row>
    </v-container>

    <!-- v-row/v-col provides a default gutter while v-layout/v-flex does not -->

    <v-container>
      <v-row no-gutters>
        <v-col>
          <v-sheet class="pa-3">v-col in v-row no-gutters</v-sheet>
        </v-col>
        <v-col>
          <v-sheet class="pa-3">v-col in v-row no-gutters</v-sheet>
        </v-col>
      </v-row>
    </v-container>

    <v-divider class="mt-3 mb-3"/>

    <v-container>
      <v-row>
        <v-col
          cols="12"
          md="6"
        >
          <v-sheet height="100">
            <v-container fill-height>
              <v-row
                align="center"
                justify="center"
              >
                <v-col cols="auto">
                  v-col
                </v-col>
              </v-row>
            </v-container>
          </v-sheet>
        </v-col>
      </v-row>
    </v-container>

    <v-container>
      <v-row no-gutters>
        <v-col
          cols="12"
          sm="8"
          md="6"
          lg="4"
          xl="2"
        >
          <v-sheet class="pa-3">
            v-col
          </v-sheet>
        </v-col>
      </v-row>
    </v-container>

    <v-divider class="mt-3 mb-3"/>

    <v-container>
      <v-row>
        <v-col
          xs12
          md6
        >
          <v-row class="ma-n3">
            <v-col
              xs12
              md6
            >
              <v-sheet class="pa-3">
                v-col
              </v-sheet>
            </v-col>

            <v-col
              xs12
              md6
            >
              <v-sheet class="pa-3">
                v-col
              </v-sheet>
            </v-col>
          </v-row>
        </v-col>

        <v-col
          xs12
          md6
        >
          <v-sheet class="pa-3">
            v-col
          </v-sheet>
        </v-col>

        <v-col cols="12">
          <v-row class="ma-n3">
            <v-col
              cols="12"
              md="4"
            >
              <v-row class="ma-n3">
                <v-col
                  cols="12"
                  md="6"
                >
                  <v-sheet class="pa-3">
                    v-col
                  </v-sheet>
                </v-col>

                <v-col
                  cols="12"
                  md="6"
                >
                  <v-sheet class="pa-3">
                    v-col
                  </v-sheet>
                </v-col>
              </v-row>
            </v-col>

            <v-col
              cols="12"
              md="8"
            >
              <v-row class="ma-n3">
                <v-col
                  cols="12"
                  md="6"
                >
                  <v-sheet class="pa-3">
                    v-col
                  </v-sheet>
                </v-col>

                <v-col
                  cols="12"
                  md="6"
                >
                  <v-sheet class="pa-3">
                    v-col
                  </v-sheet>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  export default {
    data: () => ({
      //
    }),
  }
</script>