// Copyright 2018 IBM RESEARCH. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// =============================================================================

#if os(OSX) || os(iOS)

import Foundation

// MARK: - Main body

struct StateBlochChartHtmlFactory {

    // MARK: - Public class methods

    static func makeHtml(blochStates: [[Double]]) -> String {
        var divs = ""

        let percentage = (Double(100.0) / Double(blochStates.count))
        for index in 0..<blochStates.count {
            let data = (try? JSONSerialization.data(withJSONObject: blochStates[index])) ?? Data()
            let json = String(data: data, encoding: .utf8) ?? ""

            divs += """
            <div style="position: relative; height: \(percentage)%;">
                <div id="chart\(index)" style="height: 100%;"></div>
                <div style="position: absolute; top: 0;">qubit \(index)</div>
            </div>
            <script>
                drawChart('chart\(index)', \(json));
            </script>
            """
        }

        return """
        <!doctype html>
        <html>
            <head>
                <script>
                    \(echartsBase64.base64Decoded() ?? "")
                </script>
                <script>
                    \(echartsGlBase64.base64Decoded() ?? "")
                </script>
                <script>
                    function drawChart(elementId, vector) {
                        var chart = document.getElementById(elementId);
                        var myChart = echarts.init(chart);
                        var option = {
                            xAxis3D: {},
                            yAxis3D: {},
                            zAxis3D: {},
                            grid3D: {},
                            series: [{
                                type: 'surface',
                                parametric: true,
                                itemStyle: {
                                    color: [0.5, 0.5, 0.5, 0.1]
                                },
                                wireframe: {
                                    show: false
                                },
                                parametricEquation: {
                                    u: {
                                        min: -Math.PI,
                                        max: Math.PI,
                                        step: Math.PI / 30
                                    },
                                    v: {
                                        min: 0,
                                        max: Math.PI,
                                        step: Math.PI / 30
                                    },
                                    x: function (u, v) {
                                        return Math.sin(v) * Math.sin(u);
                                    },
                                    y: function (u, v) {
                                        return Math.sin(v) * Math.cos(u);
                                    },
                                    z: function (u, v) {
                                        return Math.cos(v);
                                    }
                                }
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    color: [0.5, 0.5, 0.5]
                                },
                                data: [[0, 0, 0], [1.3, 0, 0]]
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    color: [0.5, 0.5, 0.5]
                                },
                                data: [[0, 0, 0], [0, 1.3, 0]]
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    color: [0.5, 0.5, 0.5]
                                },
                                data: [[0, 0, 0], [0, 0, 1.3]]
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    width: 6,
                                    color: [0, 0, 0]
                                },
                                data: [[0, 0, 0], vector]
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    width: 4,
                                    color: [1, 0, 0]
                                },
                                data: [[0, 0, 0], [vector[0], 0, 0]]
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    width: 4,
                                    color: [0, 1, 0]
                                },
                                data: [[0, 0, 0], [0, vector[1], 0]]
                            },
                            {
                                type: 'line3D',
                                lineStyle: {
                                    width: 4,
                                    color: [0, 0, 1]
                                },
                                data: [[0, 0, 0], [0, 0, vector[2]]]
                            }]
                        };
                        myChart.setOption(option);
                    }
                </script>
            </head>
            <body style="width: 100%; height: 100%; position: absolute;">
                \(divs)
            </body>
        </html>
        """
    }
}

#endif
