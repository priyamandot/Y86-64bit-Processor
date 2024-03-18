## Project Update: Y86-64bit Processor with Pipeline Implementation in VERILOG

We've successfully developed a fully functional Y86-64bit Processor in VERILOG, incorporating pipelining to enhance performance. This update encompasses the sequential model alongside a comprehensive pipelined version, both extensively tested.

The project's implementation can be delineated into several key stages:

1. **Fetch and PC Selection**
2. **Decode**
3. **Execute**
4. **Memory and Writeback**

![image](https://github.com/priyamandot/Y86-64bit-Processor/assets/139869341/aedf6db3-26ed-4d33-99dc-5c818be09a97)

Here's a breakdown of the pipeline's major stages:

**1. Fetch and PC Prediction**

The fetch stage retrieves instructions from memory while simultaneously predicting the Program Counter (PC) for the subsequent instruction within a single cycle. This prediction is essential for maintaining pipeline efficiency and ensuring continuous instruction processing. "Always Taken" algorithm is used to Predict PC.

**2. Decode**

The decode stage deciphers the fetched instruction from the previous cycle, extracting its opcode and preparing operands for the execution phase. This stage also entails generating control signals based on the instruction type, crucial for enabling the appropriate functional units.

**3. Execute**

During execution, the operation specified by the instruction is carried out using the fetched operands. Additionally, memory access and branch instructions are handled, with the Program Counter (PC) updated accordingly. Hazard detection and mitigation techniques are employed to ensure correct program execution.

**4. Memory**

The memory stage manages memory access for reading or writing data, handling any associated hazards. Memory-related instructions are executed, and data is passed along the pipeline as required. Techniques like caching and speculative execution are vital for optimizing memory performance.

**5. Write-back**

In the write-back stage, register updates occur, finalizing instruction execution. To prevent control hazards, instructions may be stalled until preceding instructions complete their write-back stage.

**Pipeline Control Logic**

A robust pipeline control logic is implemented to manage various scenarios, including load/use hazards, processing 'ret' instructions, and handling mispredicted branches. Techniques like bubbling and stalling are utilized judiciously to ensure correct program execution while minimizing performance overhead.
![image](https://github.com/priyamandot/Y86-64bit-Processor/assets/139869341/bde746e6-4879-45a9-b545-73c5573fbf70)

With careful handling of hazards and efficient pipeline management, we've achieved a fully operational Y86-64bit Processor capable of executing instructions seamlessly.
(For detailed explanation, please refer to the Report)
